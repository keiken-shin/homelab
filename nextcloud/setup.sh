#!/bin/bash

echo "Setting up Nextcloud"

# Create the Docker network if it doesn't exist
if ! docker network inspect stream-network &>/dev/null; then
  echo "Creating stream-network bridge..."
  docker network create stream-network
else
  echo "stream-network already exists, continuing..."
fi

# Setup Nextcloud with secrets
echo "Setting up Nextcloud..."
# Setting up volumes
mkdir -p db_data nextcloud_data

chmod +x create-secrets.sh
./create-secrets.sh

# Run docker compose
docker compose up -d

echo "Setup complete!"
echo "Nextcloud available at: http://your-server-ip:8080"