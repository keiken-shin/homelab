#!/bin/bash

echo "Setting up Jellyfin"

# Create the Docker network if it doesn't exist
if ! docker network inspect stream-network &>/dev/null; then
  echo "Creating stream-network bridge..."
  docker network create stream-network
else
  echo "stream-network already exists, continuing..."
fi

# Setup Jellyfin
mkdir -p jellyfin_config jellyfin_cache jellyfin_data
docker compose up -d

echo "Setup complete!"
echo "Jellyfin available at: http://your-server-ip:8096"