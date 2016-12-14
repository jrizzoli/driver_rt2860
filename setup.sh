#!/bin/bash

function detect() {
    if lspci -n | grep -o -q '1814:3290'; then
        echo "I: Ralink corp. RT3290 Wireless controller detected"
    else
        echo "E: Unable to find Ralink corp. RT3290 Wireless controller!"
        exit 1
    fi
}

function dependencies() {
    echo "I: Installing dependencies"

    sudo apt-get install -y build-essential linux-headers-generic autoconf automake bison flex libtool fakeroot

    if [ "$?" -ne 0 ]; then
        echo "W: Can not install dependencies"
    fi
}

function compile() {
    echo "I: Compiling"

    cd src
    make > /dev/null 2>&1

    if [ "$?" -ne 0 ]; then
        echo "E: Compilation failed!"
        exit 1
    else
        cd ..
    fi
}

function install() {
    echo "I: Installing"
    sudo ./install.sh > /dev/null 2>&1

    if [ "$?" -ne 0 ]; then
        echo "E: Installation failed"
        exit 1
    fi
}

function disable() {
    echo "I: Disabling the conflicting builtin kernel drivers"
    sudo ./blacklist.sh > /dev/null 2>&1

    if [ "$?" -ne 0 ]; then
        echo "E: Unable to disable conflicting drivers, rolling back driver installation!"
        sudo ./uninstall.sh > /dev/null 2>&1
        echo "E: Uninstalled!"
        exit 1
    fi
}

function load() {
echo "Loading the driver"
sudo ./load.sh > /dev/null 2>&1

if [ "$?" -ne 0 ]; then
    echo "E: Unable to load the driver, trying to recompile the driver..."
    if compile && install && disable; then
        echo "I: driver installed successfully"
    else
        sudo ./uninstall.sh > /dev/null 2>&1
        echo "E: Uninstalled"
        exit 1
    fi
fi

cd "`dirname "$0"`"

detect && dependencies && install && disable && load
exit 0
