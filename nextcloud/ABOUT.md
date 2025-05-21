# 🌩️ Nextcloud Docker Setup with Docker Secrets

This project sets up [Nextcloud](https://nextcloud.com/) with MariaDB using Docker Compose and Docker Secrets for secure credential management. Nextcloud provides a self-hosted file sync and share platform, giving you complete control over your data.

---

## 📁 Directory Structure

```
.
├── docker-compose.yml       # Docker Compose file for Nextcloud & MariaDB
├── setup.sh                 # Setup script to create network and run Nextcloud
├── create-secrets.sh        # Script to generate secure Docker secrets
├── secrets/                 # Directory for Docker secrets storage
├── db_data/                 # Persistent MariaDB database storage
└── nextcloud_data/          # Persistent Nextcloud data storage
```

---

## ⚙️ Prerequisites

* Docker and Docker Compose installed
* bash and openssl for generating secure passwords
* Network connectivity for pulling Docker images

---

## 🛠️ Setup Instructions

1. **Clone this repository** or create the files as shown in the directory structure.

2. **Make the setup and secrets scripts executable**:

   ```bash
   chmod +x setup.sh create-secrets.sh
   ```

3. **Run the setup script**:

   ```bash
   ./setup.sh
   ```

   This will:
   * Create a `stream-network` Docker network (if it doesn't exist)
   * Create necessary directories for persistent storage
   * Generate secure passwords and credentials using Docker secrets
   * Start the Nextcloud and MariaDB containers using Docker Compose

---

## 🔐 Docker Secrets

This setup uses Docker secrets for secure credential management:

* `mysql_root_password` - MariaDB root password
* `mysql_password` - MariaDB user password
* `mysql_user` - MariaDB username
* `mysql_database` - MariaDB database name
* `nextcloud_admin_user` - Nextcloud admin username
* `nextcloud_admin_password` - Nextcloud admin password

These secrets are generated automatically by the `create-secrets.sh` script and stored in the `secrets/` directory with proper permissions.

---

## 🐳 Docker Compose Configuration

Key details from `docker-compose.yml`:

* **Nextcloud Image**: `nextcloud:latest`
* **Database**: MariaDB 10.6 with optimized configuration
* **Network**: Uses external `stream-network` Docker network for communication
* **Port**: Exposes Nextcloud on port 8080
* **Trusted Domains**: Configured for localhost and 192.168.1.x (modify as needed)

---

## 🌐 Accessing Nextcloud

Once the containers are running, access the Nextcloud interface at:

```txt
http://192.168.1.x:8080
```

Login using the admin username and password displayed after running the setup script. Make sure to save these credentials in a secure place.

---

## 🔄 Maintenance

* **View logs**:

  ```bash
  docker compose logs -f
  ```

* **Restart services**:

  ```bash
  docker compose restart
  ```

* **Update containers**:

  ```bash
  docker compose down
  docker compose pull
  docker compose up -d
  ```

---

## 🧽 Cleanup

To stop and remove the containers:

```bash
docker compose down
```

To completely remove all data (use with caution):

```bash
docker compose down
rm -rf db_data nextcloud_data secrets
```

---

## 📝 Notes

* The default Nextcloud admin username is "admin"
* The admin password is automatically generated and displayed during setup
* The database credentials are securely stored in Docker secrets
* All data is persisted in the `db_data` and `nextcloud_data` directories
* Nextcloud is configured to trust specific domains - add more in the `NEXTCLOUD_TRUSTED_DOMAINS` environment variable if needed