#!/bin/bash -e

install -m 644 files/frontend.zip "${ROOTFS_DIR}/opt/"

on_chroot <<EOF
rm -dfr /opt/mirror-backend
git clone https://${GH_USER}:${GH_PASS}@github.com/uoClarify/mirror-backend.git /opt/mirror-backend
cd /opt/mirror-backend && pip install -r requirements.txt
chown -R clarify:clarify /opt/mirror-backend

rm -dfr /opt/mirror-frontend
mkdir -p /opt/mirror-frontend
unzip /opt/frontend.zip -d /opt/mirror-frontend
rm /opt/frontend.zip
chmod +x /opt/mirror-frontend/clarify
chown -R clarify:clarify /opt/mirror-frontend
EOF
