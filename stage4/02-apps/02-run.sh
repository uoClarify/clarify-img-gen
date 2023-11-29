#!/bin/bash -e

# Install account key
install -m 600 files/stt-account-key.json "${ROOTFS_DIR}/opt/mirror-backend/"

# Edit .env file to contain actual variable values
on_chroot << EOF
cp /opt/mirror-backend/.env.default /opt/mirror-backend/.env 
# Picovoice key contains /, use | as delimiter
sed -i "s|PICOVOICE_KEY=CHANGE|PICOVOICE_KEY=${PICOVOICE_KEY}|" /opt/mirror-backend/.env
sed -i "s/GOOGLE_API_KEY=CHANGE/GOOGLE_API_KEY=${GOOGLE_API_KEY}/" /opt/mirror-backend/.env
sed -i "s/SPOTIFY_CLIENT_ID=CHANGE/SPOTIFY_CLIENT_ID=${SPOTIFY_CLIENT_ID}/" /opt/mirror-backend/.env
sed -i "s/SPOTIFY_CLIENT_SECRET=CHANGE/SPOTIFY_CLIENT_SECRET=${SPOTIFY_CLIENT_SECRET}/" /opt/mirror-backend/.env
sed -i "s/OWM_API_KEY=CHANGE/OWM_API_KEY=${OWM_API_KEY}/" /opt/mirror-backend/.env
sed -i "s/OPENAI_API_KEY=CHANGE/OPENAI_API_KEY=${OPENAI_API_KEY}/" /opt/mirror-backend/.env
EOF
