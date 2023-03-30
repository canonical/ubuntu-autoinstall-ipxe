# iPXE based provisioning of Ubuntu Desktop 23.04 and later


- [iPXE based provisioning of Ubuntu Desktop 23.04 and later](#ipxe-based-provisioning-of-ubuntu-desktop-2304-and-later)
  - [Introduction](#introduction)
  - [Requirements](#requirements)
  - [Installation](#installation)
    - [Create deployment configuration](#create-deployment-configuration)
  - [Configure system](#configure-system)
  - [Deployment configuration](#deployment-configuration)
  - [Deployment example](#deployment-example)

## Introduction

In some environments, it's very useful to be able to automate the installation/provisioning of Ubuntu Desktop systems.  There are several ways to achieve this, in this guide we'll discuss autoinstall via the network.  Often this is the most scalable way to achieve this, simply boot the device via PXE from the network and select which configuration to apply at install.  Leveraging iPXE this could also be achieved simply over http without the need for DHCP/TFTP configuration of your network.

To achieve this, we'll need a server running a web server to serve the content necessary to perform the installation.  It's also desirable to be able to cache content that's necessary to be downloaded during installation, preventing every device being installed from needing to download the same content.  We'll cover doing this with a caching proxy designed specifically for debian packages.

## Requirements

 * apache2 (to serve installation related files)
 * squid-deb-proxy (caching proxy to cache debs on local server)

## Installation

Install necessary packages:
```
sudo apt install apache2 squid-deb-proxy
```

### Create deployment configuration

Clone this repository to /var/www/html/ubuntu-autoinstall-ipxe and run the bootstrap.sh script from that directory.  This script will apply some patches to the squid-deb-proxy and apache2 config files to setup the deployment server.


## Configure system
```
sudo ./bootstrap.sh
```

## Deployment configuration

There are a couple of key things to know about the structure of the files and directories provided.

**ipxe** - defines a menu displayed to select boot targets as well as each target boot arguments

**etc** - contains patches to configuration files, which are applied by the bootstrap.sh script

**ubuntu/23.04** - contains files required for for autoinstall of Ubuntu Desktop 23.04

**ubuntu/23.04/iso** - this is where the installation iso will be mounted, providing necessary files to network boot the devices.

**ubuntu/23.04/ubuntu-23.04-desktop-amd64.iso** - [Ubuntu Desktop 23.04 installation iso](http://cdimage.ubuntu.com/daily-live/pending/lunar-desktop-amd64.iso)

**ubuntu/23.04/vendor-data** - can be empty, see [cloud-init documentation](https://cloudinit.readthedocs.io/en/latest/) for more details.

**ubuntu/23.04/meta-data** - can be empty, see [cloud-init documentation](https://cloudinit.readthedocs.io/en/latest/) for more details.

**ubuntu/23.04/user-data** - This is where the magic happens!  This file will contain your autoinstall configuration, see the [reference documentation](https://ubuntu.com/server/docs/install/autoinstall-reference) for more details.

For this guide, our vendor-data and meta-data files are empty, just note they are required to exist.

The user-data file is a yaml file defining your installation.  This is where additional packages to install, storage layout, etc are all configurable.


## Deployment example

To install a system, boot via iPXE (for example the iso available from https://ipxe.org/download)

At the iPXE prompt:
```
IPXE> dhcp
IPXE> chain http://boot.linuxgroove.com/ipxe
```

This will then display the iPXE menu with each item defined your your ipxe file (at the root of this repo)

Alternatively, you can configure a PXE server to load your iPXE environment.

NOTES:

To create the password used in the identity section:

```
echo password|mkpasswd -m sha-512 -s
```
