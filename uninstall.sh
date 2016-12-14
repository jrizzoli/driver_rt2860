#!/bin/bash

cd "`dirname "$0"`"

cd src
make uninstall

rm /lib/firmware/rt3290.bin
rm /etc/modprobe.d/blacklist-ralink.conf

exit 0
