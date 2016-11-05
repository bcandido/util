#!/bin/bash

LOG_FILE="mouse_sensitivity.log"
MOUSE_NAME="Logitech M705"
SENSITIVITY="2.0"
VELOCITY="10"

touch $LOG_FILE

log() {
  echo "[$(date "+%Y-%m-%d %H:%M:%S")] $@" >> $LOG_FILE
}

xinput --list | grep "$MOUSE_NAME" > /dev/null
if [ $? -eq 1 ]; then
  log "Device not found. Script will be interrupted"
  exit 1
fi

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
