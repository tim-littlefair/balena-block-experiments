#!/bin/sh

device_ipaddr=$1
container_basename=$2

echo "
    balena container list -a 
    balena container stop ${container_basename}_1_1_10ca12e1ea5e
    balena container rm ${container_basename}_1_1_10ca12e1ea5e
    balena container list -a 
" | balena device ssh $device_ipaddr


