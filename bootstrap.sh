#!/bin/bash
#
checkout=$PWD
cd /etc/squid-deb-proxy/
patch -p1 < $checkout/etc/squid-deb-proxy/mirror-dstdomain.acl.d/10-default.diff
patch -p1 < $checkout/etc/squid-deb-proxy/squid-deb-proxy.conf.diff
cd /etc/apache2/sites-enabled/
patch -p1 < $checkout/etc/apache2/sites-enabled/000-default.conf.diff
echo "Bootstrap complete"
cd $checkout
