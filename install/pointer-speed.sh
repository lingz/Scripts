#!/bin/bash

sudo apt-get install sysfsutils

message="Add these lines to /etc/sysfs.conf
#devices/platform/i8042/serio1/serio2/speed = 150
#devices/platform/i8042/serio1/serio2/sensitivity = 180"

echo "$message"
