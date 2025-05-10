#!/bin/bash

# Create secrets directory if it doesn't exist
mkdir -p secrets

# Generate random passwords for the database
MYSQL_ROOT_PASSWORD=$(openssl rand -base64 32 | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
MYSQL_PASSWORD=$(openssl rand -base64 32 | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)

# Set database values
echo "nextcloud" > secrets/mysql_database.txt
echo "nextcloud_user" > secrets/mysql_user.txt
echo "$MYSQL_ROOT_PASSWORD" > secrets/mysql_root_password.txt
echo "$MYSQL_PASSWORD" > secrets/mysql_password.txt

# Set Nextcloud admin credentials
echo "admin" > secrets/nextcloud_admin_user.txt
echo "$(openssl rand -base64 32 | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1)" > secrets/nextcloud_admin_password.txt

# Set proper permissions
chmod 600 secrets/*.txt

echo "Secrets created successfully in the 'secrets' directory."
echo "Nextcloud admin username: admin"
echo "Nextcloud admin password: $(cat secrets/nextcloud_admin_password.txt)"
echo "Please store these credentials in a safe place."