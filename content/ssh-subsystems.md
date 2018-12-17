Title: Protocols over SSH
Date: 2018-12-16
Category: SSH
Status: Draft

Why SSH?
========

The big reason is authentication.

Common HTTP Authentication methods:

* HTTP Authentication (Basic, Digest, or Bearer)
* User/password plus cookies
* OAuth plus cookies
* Above, plus TOTP, U2F (plus cookies)
* Kerberos
* TLS Certificates

Few of these are particularly well standardized, several are fairly complex, and
almost none are commonly available on clients. And no clients share
authentication information. In addition, the constant sending of authentication
information directly leads to the [CRIME](https://en.wikipedia.org/wiki/CRIME)
attack.


Common SSH Authentication methods:

* Username/password
* Public/private keys
* Keys stored on hardware
* TOTP (via keyboard-interactive authentication)
* OpenSSH Certificates
* Kerberos

All of these are standardized and well supported by multiple clients. They can
share authentication and configuration settings, even using a shared connection
between multiple clients.

Ok, a part of that is because OpenSSH is ubiquitous.

In addition, the ecosystem around SSH is made for administrative actions and can
readily handle auditing.


Why Subsystems?
===============

* Don't need to write a mock shell
* Don't need to work with shells
* Easier to distinguish shell/exec and subsystem permissions
* Allows administrators to drop in alternate implementations, configurations, etc

Basically, having explicit, well-defined names for things is better.


Why MessagePack?
================

* JSON compatible
* Self-framing
* Compact
* Schemaless
* Salt is already using it for all its communications

Because of the ill-defined (and sometimes dynamic) nature of Salt calls,
schemaless was necessary.
