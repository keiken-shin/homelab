#!/bin/bash

# Create the macvlan network if it doesn't exist
if ! docker network ls | grep -q pihole_macvlan; then
  echo "Creating macvlan network..."
  # Note: Parent should be host network name
  docker network create \
    -d macvlan \
    --subnet=192.168.1.0/24 \
    --gateway=192.168.1.1 \
    -o parent=ens32 \
    pihole_macvlan
else
  echo "macvlan network already exists."
fi

# Start the Pi-hole container
docker compose up -d
