#!/bin/bash

cd "`dirname "$0"`"

modprobe rt3290sta

if [ "$?" -ne 0 ]; then
    exit 1
fi

for i in `ifconfig -s -a | cut -f1 -d " "`;
do
    if [ "$i" != "Iface" ]; then
        ifconfig $i up
        if [ "$?" -ne 0 ]; then
            exit 1
        fi
    fi
done

service network-manager restart

exit 0
