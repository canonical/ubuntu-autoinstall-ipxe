#!/bin/bash
#
checkout=$PWD
cd /etc/squid-deb-proxy/
patch -p1 < $checkout/etc/squid-deb-proxy/mirror-dstdomain.acl.d/10-default.diff
patch -p1 < $checkout/etc/squid-deb-proxy/squid-deb-proxy.conf.diff
cd /etc/apache2/sites-available/
patch -p1 < $checkout/etc/apache2/sites-available/000-default.conf.diff

cp /etc/fstab /etc/fstab.orig

wget -O $checkout/ubuntu/22.04/server-22.04.2.iso https://mnvoip.mm.fcix.net/ubuntu-releases/22.04.2/ubuntu-22.04.2-live-server-amd64.iso
echo "/var/www/html/ubuntu-autoinstall-iso/ubuntu/22.04/server-22.04.2.iso /var/www/html/ubuntu-autoinstall-iso/ubuntu/22.04/iso iso9660 loop,ro,auto 0 0" >> /etc/fstab

echo "Bootstrap complete"
cd $checkout
