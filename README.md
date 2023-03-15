iPXE based provisioning of Ubuntu 22.04 and later

Requirements:
 * apache2 (to serve installation related files)
 * squid-deb-proxy (caching proxy to cache debs on local server)

To setup:
```
sudo apt install apache2 squid-deb-proxy
```

Clone this repository to /var/www/html/ubuntu-autoinstall-ipxe and run the bootstrap.sh script from that directory.  This script will apply some patches to the squid-deb-proxy and apache2 config files to setup the deployment server.

```
sudo ./bootstrap.sh
```

To install a system, boot via iPXE (for example the iso available from https://ipxe.org/download)

At the iPXE prompt:
```
IPXE> dhcp
IPXE> chain http://boot.linuxgroove.com/ipxe
```

This will then display the iPXE menu with each item defined your your ipxe file (at the root of this repo)

NOTES:

To create the password used in the identity section:

```
echo password|mkpasswd -m sha-512 -s
```

