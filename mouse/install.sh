#!/bin/bash
PROG="mouse_sensitivity.sh"
DIR="/opt/mouse"

DEVICE="$(xinput --list-props "Logitech M705" | grep "Device Node" | cut -d'"' -f2)"
SERIAL="$(udevadm info -q property -n /dev/input/event6 | grep ID_PATH= | cut -d'-' -f2)"
CONFIG="SUBSYSTEMS==\"usb\", ATTRS{serial}==\"$SERIAL\", RUN+=\"$DIR/$PROG\""
RULE="logitech-m705.rules"

# check if is root
[ "$USER" != "root" ] && echo "run script as root" && exit 1

[ ! -e $DIR ] && mkdir $DIR
cp -f $PROG $DIR/$PROG

echo "$CONFIG" > /etc/udev/rules.d/logitech-m705.rules
udevadm control --reload
