#!/bin/sh

TIMEOUT=10

function logn {
  echo "droid-hcismd-up:" $@ | systemd-cat -p notice
}

function logd {
  echo "droid-hcismd-up:" $@ | systemd-cat -p debug
}

function loge {
  echo "droid-hcismd-up:" $@ | sysnted-cat -p err
}

function wait_for_path {
  local TIME=0
  logd "Waiting for... " $1
  while [ "$TIME" -lt "$TIMEOUT" ]; do
    if [ -e $1 ]; then
      return 0
    fi
    sleep 1
    TIME=$((TIME + 1))
  done
  loge "Timed out!"
  return -1
}

function wait_for_property_to_equal {
  local TIME=0
  logd "Waiting for..." getprop $1 == $2
  while [ "$TIME" -lt "$TIMEOUT" ]; do
    if [ `getprop $1` == $2  ]; then
      return 0
    fi
    sleep 1
    TIME=$(($TIME + 1))
  done
  loge "...Timed out!"
  return -1
}

logn "Initializing Bluetooth"

wait_for_path "/dev/smd3" || exit -1
wait_for_property_to_equal "ro.qualcomm.bt.hci_transport" "smd" || exit -1

logd "Requesting BT Mac address"
bt_mac=$(/system/bin/hci_qcomm_init -e -p 2 -P 2 -d /dev/ttyHSL0 2>&1 | grep -oP '([0-9a-f]{2}:){5}([0-9a-f]{2})')
logd "BT MAC: $bt_mac"
if [ ! -z "$bt_mac" ] ; then
  echo $bt_mac > /var/lib/bluetooth/board-address
else
  loge "Couldn't find BT Mac address"
  exit -1
fi

wait_for_path "/sys/module/hci_smd/parameters/hcismd_set" || exit -1
echo 1 > /sys/module/hci_smd/parameters/hcismd_set

logn "Bluetooth initialized"
