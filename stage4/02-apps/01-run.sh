#!/bin/bash -e

# Install files
install -m 644 files/clarify-backend.service "${ROOTFS_DIR}/etc/systemd/system/"
install -m 644 files/clarify-frontend.service "${ROOTFS_DIR}/etc/systemd/system/"

# Enable services
on_chroot << EOF
systemctl enable clarify-backend
systemctl enable clarify-frontend
EOF
