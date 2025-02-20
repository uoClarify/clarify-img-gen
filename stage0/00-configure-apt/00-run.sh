#!/bin/bash -e

install -m 644 files/sources.list "${ROOTFS_DIR}/etc/apt/"
install -m 644 files/raspi.list "${ROOTFS_DIR}/etc/apt/sources.list.d/"
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" > ${ROOTFS_DIR}/etc/apt/sources.list.d/nodesource.list
sed -i "s/RELEASE/${RELEASE}/g" "${ROOTFS_DIR}/etc/apt/sources.list"
sed -i "s/RELEASE/${RELEASE}/g" "${ROOTFS_DIR}/etc/apt/sources.list.d/raspi.list"

if [ -n "$APT_PROXY" ]; then
	install -m 644 files/51cache "${ROOTFS_DIR}/etc/apt/apt.conf.d/51cache"
	sed "${ROOTFS_DIR}/etc/apt/apt.conf.d/51cache" -i -e "s|APT_PROXY|${APT_PROXY}|"
else
	rm -f "${ROOTFS_DIR}/etc/apt/apt.conf.d/51cache"
fi

cat files/raspberrypi.gpg.key | gpg --dearmor > "${STAGE_WORK_DIR}/raspberrypi-archive-stable.gpg"
install -m 644 "${STAGE_WORK_DIR}/raspberrypi-archive-stable.gpg" "${ROOTFS_DIR}/etc/apt/trusted.gpg.d/"

# Install nodesource key
cat files/nodesource-repo.gpg.key | gpg --dearmor > "${STAGE_WORK_DIR}/nodesource-repo.gpg"
install -D -m 644 "${STAGE_WORK_DIR}/nodesource-repo.gpg" "${ROOTFS_DIR}/etc/apt/keyrings/nodesource.gpg"

on_chroot << EOF
dpkg --add-architecture armhf
apt-get update
apt-get dist-upgrade -y
EOF
