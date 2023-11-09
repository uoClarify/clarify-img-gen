#!/bin/bash -e

# Install files
install -m 644 files/clarify-backend.service "${ROOTFS_DIR}/etc/systemd/system/"
install -m 644 files/clarify-frontend.service "${ROOTFS_DIR}/etc/systemd/system/"
