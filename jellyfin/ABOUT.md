# 🎬 Jellyfin Media Server Docker Setup

This project sets up [Jellyfin](https://jellyfin.org/) - a free and open-source media server - using Docker Compose. Jellyfin lets you collect, organize, and stream your media to any device. This setup includes persistent volumes for configuration, cache, and media storage.

---

## 📁 Directory Structure

```
.
├── docker-compose.yml      # Docker Compose file for Jellyfin
├── setup.sh                # Setup script to create network and run Jellyfin
├── jellyfin_config/        # Persistent Jellyfin configuration
├── jellyfin_cache/         # Persistent cache storage
└── jellyfin_data/          # Media files storage
```

---

## ⚙️ Prerequisites

* Docker and Docker Compose installed
* Network connectivity for pulling Docker images
* Media files to stream (optional)

---

## 🛠️ Setup Instructions

1. **Clone this repository** or create the files as shown in the directory structure.

2. **Make the setup script executable**:

   ```bash
   chmod +x setup.sh
   ```

3. **Edit the `docker-compose.yml` file** if needed:
   * Update the IP address in `JELLYFIN_PublishedServerUrl` to match your server's IP
   * Adjust volume paths if you want to use different directories for media

4. **Run the setup script**:

   ```bash
   ./setup.sh
   ```

   This will:
   * Create a `stream-network` Docker network (if it doesn't exist)
   * Create directories for configuration, cache, and media
   * Start the Jellyfin container using Docker Compose

---

## 🐳 Docker Compose Configuration

Key details from `docker-compose.yml`:

* **Image**: `jellyfin/jellyfin:latest`
* **Ports**:
  * 8096: HTTP interface
  * 8920: HTTPS interface
  * 7359: Service discovery (UDP)
  * 1900: DLNA discovery (UDP)
* **Network**: Uses external `stream-network` Docker network
* **Environment**: Configured with your server's IP (default: 192.168.1.x)

---

## 📂 Volumes

The setup includes three main persistent volumes:

* **jellyfin_config**: Stores Jellyfin's configuration
* **jellyfin_cache**: Stores transcoding cache and other temporary files
* **jellyfin_data**: Stores your media files (movies, TV shows, music, etc.)

---

## 🌐 Accessing Jellyfin

Once the container is running, access the Jellyfin interface at:

```
http://192.168.1.x:8096
```

The first time you access it, you'll need to complete the setup wizard:

1. Choose your preferred language
2. Create an admin user
3. Set up your media libraries
4. Configure other settings as desired

---

## 📚 Adding Media

Place your media files in the `jellyfin_data` directory. You can organize them into subdirectories:

```
jellyfin_data/
├── Movies/
├── TV/
├── Music/
└── Photos/
```

After adding new media, scan your libraries in the Jellyfin web interface.

---

## 🔄 Maintenance

* **View logs**:

  ```bash
  docker compose logs -f
  ```

* **Restart Jellyfin**:

  ```bash
  docker compose restart
  ```

* **Update Jellyfin**:

  ```bash
  docker compose down
  docker compose pull
  docker compose up -d
  ```

---

## 🧽 Cleanup

To stop and remove the container:

```bash
docker compose down
```

To completely remove all data (use with caution):

```bash
docker compose down
rm -rf jellyfin_config jellyfin_cache jellyfin_data
```

---

## 📝 Notes

* Jellyfin is accessible on port 8096 for HTTP and 8920 for HTTPS
* Your media is stored in the `jellyfin_data` directory
* Service discovery is enabled for finding Jellyfin on your local network
* DLNA is enabled for streaming to compatible devices

