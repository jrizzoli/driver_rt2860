#!/bin/bash

RRVal=0

CDIR="`dirname "$0"`"

if [ $CDIR == "." ]; then
    CDIR="`pwd`"
fi

cd $CDIR

bash setup.sh

RET=$?

if [ $RET -ne 0 ]; then
    echo "Installation failed"
else
    echo "Installed successfully"
fi

exit $RET
