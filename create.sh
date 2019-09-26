#!/bin/sh

set -au

yubico-piv-tool -aversion
K=$(dd if=/dev/random bs=1 count=24 2>/dev/null | hexdump -v -e '/1 "%02X"')

yubico-piv-tool -aset-mgm-key -n${K}

echo -n "Enter PIN: "
read PIN
echo -n "Enter PUK: "
read PUK

yubico-piv-tool -achange-pin -P123456 -N${PIN}
yubico-piv-tool -achange-puk -P12345678 -N${PUK}

echo -n "Enter comment for SSH key: "
read COMMENT
ssh-keygen -m PEM -t ecdsa -b 384 -C "${COMMENT}" -f yubikey_ecdsa384

mv yubikey_ecdsa384 yubikey_ecdsa384.key
yubico-piv-tool --key=${K} --pin-policy=never --touch-policy=always -s 9a \
	-a import-key -i yubikey_ecdsa384.key

openssl ec -inform PEM -in yubikey_ecdsa384.key -outform PEM \
	-pubout -out yubikey_ecdsa384.public

echo "Creating self-signed certificate. Touch the key to authorize."
yubico-piv-tool -a verify -a selfsign --valid-days 3650 -s 9a \
	-S "/CN=${COMMENT}/" -i yubikey_ecdsa384.public -o yubikey_cert.pem

yubico-piv-tool --key=${K} --pin-policy=never --touch-policy=always \
	-a import-certificate -s 9a -i yubikey_cert.pem

echo ""
cat yubikey_ecdsa384.pub
echo ""

#rm -v yubikey_*
