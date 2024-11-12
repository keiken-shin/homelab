# Personal Cloud Suite

Personal Cloud Suite is a self-hosted setup for managing personal cloud storage, media streaming, and data access. Built with Nextcloud, Jellyfin, Shoko Server, and NGINX Proxy Manager, it provides a unified solution for secure, private cloud storage and seamless media streaming across devices.

## Services Overview

This server setup includes:

- **Nextcloud**: Private cloud storage.
- **Jellyfin**: Media server for streaming content.
- **Shoko Server**: Manages anime content metadata.
- **MariaDB**: Database server for Nextcloud.
- **Redis**: Caching for improved performance.
- **NGINX Proxy Manager**: Manages access and security, including SSL.

## Folder Structure

Below is the recommended folder structure for this setup:

```.txt
- <PATH_TO_NEXTCLOUD_DIR>
    - config/               # Stores persistent Nextcloud configuration files
    - custom/               # Holds custom Nextcloud apps
    - data/                 # Main storage for user data and files in Nextcloud
    - db/                   # Stores MariaDB data for Nextcloud
    - external/             # Placeholder for external storage integration
    - html/                 # Main Nextcloud application folder
    - jellyfin/             # Jellyfin media server configuration and data
        - cache/            # Jellyfin cache directory
        - config/           # Jellyfin configuration directory
        - media/            # Shared media folder accessible by Jellyfin and Nextcloud
    - letsencrypt/          # Stores SSL certificates managed by NGINX Proxy Manager
    - redis/                # Redis data for caching
    - shoko/                # Shoko Server configuration and media paths
        - config            # Shoko configuration files
    - docker-compose.yml    # Docker Compose file defining services and volumes
    - nextcloud-init.sh     # Initialization script for Nextcloud data and permissions
```

## Files Overview

### `docker-compose.yml`

The primary file for setting up and configuring containers. It defines each service, their ports, environment variables, and volumes.

#### Key Services

- **app**: Runs the Nextcloud application and relies on `nextcloud-init.sh` to handle `.ncdata` initialization.
- **db**: The MariaDB database for Nextcloud.
- **redis**: Provides caching for Nextcloud to enhance performance.
- **jellyfin**: Streams media across the network.
- **shoko**: Manages anime metadata and links to Jellyfin's anime media folder.
- **nginx-proxy**: Manages incoming requests and SSL via NGINX.

#### Volumes

Each service uses volumes to persist data locally:

- `html`: Main Nextcloud folder, essential for updates.
- `data`: Actual data stored in Nextcloud.
- `config`: Nextcloud configuration files.
- `external`: Placeholder for future external storage integration.
- `jellyfin`: Shared media folder to give Jellyfin access to Nextcloud-stored media.

#### Networks

All services share the same `cloud` network for easy communication.

### `nextcloud-init.sh`

This script initializes Nextcloud by ensuring necessary files and permissions are in place. Key functionalities:

- **`.ncdata` Fix**: Creates an `.ncdata` file in the Nextcloud data directory if it’s missing. This prevents Nextcloud from entering maintenance mode due to a missing `.ncdata` file.
- **Shared Group Setup**: Checks if the `sharedmedia` group exists; if not, creates it with GID 1001. Adds the `www-data` user (used by Nextcloud) to this group for shared access to media.
- **Apache Start**: Starts Apache in the foreground.

## Initial Setup Instructions

1. **Clone Repository**: Clone this repository and navigate to the directory.
2. **Environment Variables**: Customize the `docker-compose.yml` by filling in placeholder values (e.g., `MYSQL_DATABASE`, `NEXTCLOUD_ADMIN_USER`) with your desired settings.
3. **Set Up Shared Permissions**:
   - Run these commands to set up the `sharedmedia` group on the host, ensuring Nextcloud and Jellyfin have shared access:

     ```sh
     sudo groupadd -g 1001 sharedmedia
     sudo usermod -aG sharedmedia $(whoami)
     ```

   - Adjust permissions on the media folder:

     ```sh
     sudo chown -R 1000:1001 ./jellyfin/media
     sudo chmod -R 775 ./jellyfin/media
     ```

## Usage Notes

- **Shared Permissions**: The `sharedmedia` group enables file manipulation across applications without "Access Denied" errors.
- **`.ncdata` Error**: Sometimes Nextcloud enters maintenance mode if the `.ncdata` file is missing. This is addressed in `nextcloud-init.sh`.
- **Database Transaction Settings**: In `db`, `--transaction-isolation=READ-COMMITTED --binlog-format=ROW` improves compatibility with Nextcloud.
