#!/bin/sh

yubico-piv-tool -averify-pin -P471112
yubico-piv-tool -averify-pin -P471112
yubico-piv-tool -averify-pin -P471112
yubico-piv-tool -averify-pin -P471112
yubico-piv-tool -achange-puk -P471112 -N6756789
yubico-piv-tool -achange-puk -P471112 -N6756789
yubico-piv-tool -achange-puk -P471112 -N6756789
yubico-piv-tool -achange-puk -P471112 -N6756789
yubico-piv-tool -areset
yubico-piv-tool -aset-chuid
yubico-piv-tool -aset-ccc
