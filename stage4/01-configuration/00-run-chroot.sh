#!/bin/bash -e

chown clarify:clarify /opt

echo "i2c-dev" >/etc/modules
sed -i "s/^#dtparam=i2c_arm=on/dtparam=i2c_arm=on/" /boot/config.txt

# Auto login into clarify account
sed -i "s/#autologin-user=.*/autologin-user=clarify/" /etc/lightdm/lightdm.conf

# Configure xserver (disable mouse cursor, screen blanking)
sed -i '/^\[Seat:\*\]/,$s/#xserver-command=X/xserver-command=X -bs -core -nocursor -s 0 dpms/' /etc/lightdm/lightdm.conf

# Configure WiFi (wpa_supplicant)
wpa_passphrase VLaptop Clarify1! | tee -a /etc/wpa_supplicant/wpa_supplicant.conf
cp /lib/systemd/system/wpa_supplicant.service /etc/systemd/system/wpa_supplicant.service
sed -i "/^ExecStart/ s/$/ -i wlan0/" /etc/systemd/system/wpa_supplicant.service
sed -i "/wlan0$/a Restart=always" /etc/systemd/system/wpa_supplicant.service
