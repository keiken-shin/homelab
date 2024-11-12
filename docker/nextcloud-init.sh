# Path to Nextcloud data directory
DATA_DIR="/var/www/html/data"

# Ensure .ncdata file exists with the required conten
if [ ! -f "$DATA_DIR/.ncdata" ]; then
  echo "# Nextcloud data directory" > "$DATA_DIR/.ncdata"
  echo ".ncdata file created in $DATA_DIR"
fi

# Set the correct permissions for the data directory
chown -R www-data:www-data "$DATA_DIR"
chmod -R 750 "$DATA_DIR"

# Look inside README file for shared permission setup
# Ensure sharedmedia group exists, add www-data to it, and start Apache
getent group sharedmedia || groupadd -g 1001 sharedmedia && usermod -aG sharedmedia www-data

# Start Apache in the foreground
exec apache2-foreground