#!/bin/bash

cd "`dirname "$0"`"
cd src

make install

if [ "$?" -ne 0 ]; then
    exit 1
fi

cd ..
cd firmware
mkdir -p /lib/firmware/
cp rt3290.bin /lib/firmware/

exit 0
