#!/bin/bash -e

chown clarify:clarify /opt

echo "i2c-dev" >/etc/modules
sed -i "s/^#dtparam=i2c_arm=on/dtparam=i2c_arm=on/" /boot/config.txt

# Auto login into clarify account
sed -i "s/#autologin-user=.*/autologin-user=clarify/" /etc/lightdm/lightdm.conf

# Disable mouse cursor
sed -i '/^\[Seat:\*\]/,$s/#xserver-command=X/xserver-command=X -bs -core -nocursor/' /etc/lightdm/lightdm.conf
