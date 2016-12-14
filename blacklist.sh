#!/bin/bash

cd "`dirname "$0"`"

modprobe -r rt2800pci
modprobe -r rt2x00pci

cp blacklist-ralink.conf /etc/modprobe.d/

exit $?
