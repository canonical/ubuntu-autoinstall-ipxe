iPXE based provisioning of Ubuntu 22.04 and later

Requirements:
 * apache2 (to serve installation related files)
 * squid-deb-proxy (caching proxy to cache debs on local server)

To setup:
```
sudo apt install apache2 squid-deb-proxy
```

Clone this repository to /var/www/html/ubuntu-autoinstall-ipxe and run the bootstrap.sh script from that directory

```
sudo ./bootstrap.sh
```

NOTES:

To create the password used in the identity section:

```
echo password|mkpasswd -m sha-512 -s
```

