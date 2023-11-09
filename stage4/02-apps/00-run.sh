#!/bin/bash -e

on_chroot <<EOF
rm -dfr /opt/mirror-backend
git clone https://${GH_USER}:${GH_PASS}@github.com/uoClarify/mirror-backend.git /opt/mirror-backend
cd /opt/mirror-backend && pip install -r requirements.txt
chown clarify:clarify /opt/mirror-backend

rm -dfr /opt/mirror-frontend
git clone https://${GH_USER}:${GH_PASS}@github.com/uoClarify/mirror-app /opt/mirror-frontend
cd /opt/mirror-frontend && npm install
chown clarify:clarify /opt/mirror-frontend

EOF
