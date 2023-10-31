#!/bin/bash -e

chown clarify:clarify /opt

echo "i2c-dev" > /etc/modules
sed -i "s/^#dtparam=i2c_arm=on/dtparam=i2c_arm=on/" /boot/config.txt
