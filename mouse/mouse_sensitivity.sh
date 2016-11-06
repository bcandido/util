#!/bin/bash

LOG_FILE="mouse_sensitivity.log"
LOG_PATH=$(dirname ${BASH_SOURCE[0]})

MOUSE_NAME="Logitech M705"
SENSITIVITY="2.0"
VELOCITY="10"

cd $LOG_PATH
[ ! -e $LOG_FILE ] && touch $LOG_FILE && chmod +w $LOG_FILE

log() {
  DATA=$(date "+%Y-%m-%d %H:%M:%S")
  echo "[$DATA] $@" >> $LOG_FILE
}

xinput --list | grep "$MOUSE_NAME" > /dev/null
[ $? -eq 1 ] && log "Device not found. Script will be interrupted" && exit 1

log "Device $MOUSE_NAME found"
xinput --set-prop "$MOUSE_NAME" "Device Accel Constant Deceleration" $SENSITIVITY
if [ $? -eq 0 ]; then
  log "Device Accel Constant Deceleration set to $SENSITIVITY"
else
  log "Unable to set Device Accel Constant Deceleration"
fi

xinput --set-prop "$MOUSE_NAME" "Device Accel Velocity Scaling" $VELOCITY
if [ $? -eq 0 ]; then
 log "Device Accel Velocity Scaling set to $VELOCITY"
else
  log "Unable to set Device Accel Velocity Scaling"
fi

log "---"
