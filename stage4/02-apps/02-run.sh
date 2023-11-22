#!/bin/bash -e

# Install account key
install -m 600 files/stt-account-key.json "${ROOTFS_DIR}/opt/mirror-backend/"

# Edit .env file to contain actual variable values
on_chroot << EOF
cp /opt/mirror-backend/.env.default /opt/mirror-backend/.env 
# Picovoice key contains /, use | as delimiter
sed -i "s|PICOVOICE_KEY=CHANGE|PICOVOICE_KEY=${PICOVOICE_KEY}|" /opt/mirror-backend/.env
sed -i "s/GOOGLE_API_KEY=CHANGE/GOOGLE_API_KEY=${GOOGLE_API_KEY}/" /opt/mirror-backend/.env
EOF
