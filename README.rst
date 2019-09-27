YubiKey SSH
===========

create.sh
---------

Installs an ssh key (ecdsa384) as described by benno@ in this undeadly article:

 - https://undeadly.org/cgi?action=article;sid=20190302235509

reset.sh
--------

Resets a provisioned youbikey back do defaults (PIN, PUK, No key material).

PREREQS
=======

```
pkg_add yubico-piv-tool
```
