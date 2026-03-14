#!/bin/sh

# Copy firmware
sudo mkdir -p /lib/firmware/aic8800dc
sudo cp ../fw/* /lib/firmware/aic8800dc/

# Install DKMS
DRV_NAME="aic8800"
DRV_VERSION="1.0.0"
sudo cp -r . /usr/src/${DRV_NAME}-${DRV_VERSION}
sudo dkms add -m ${DRV_NAME} -v ${DRV_VERSION}
sudo dkms build -m ${DRV_NAME} -v ${DRV_VERSION}
sudo dkms install -m ${DRV_NAME} -v ${DRV_VERSION}

# Suggestions
printf "If you encounter problems when installing drivers, check steps below:\n" \
    "1. Install the package \"usb_modeswitch\", then run \"lsusb\" to see the vendor ID of the network card.\n" \
    "\tYou will see something similar to this \"Bus 002 Device 005: ID {VID}:{DID} aicsemi Aic MSC\".\n" \
    "\tAnd then run \"sudo usb_modeswitch -v {VID} -p {DID} -K\". Notice that {VID} and {DID} are two specific code, not really \"{VID}\" or \"{DID}\"!\n" \
    "2. You may have compiling problems. If you saw some text with red color when compiling, submit an issue to me with the log.\n" \
    "3. Your kernel is old. This driver is for Linux 6.1+ only.\n"
