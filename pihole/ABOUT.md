# 🧱 Pi-hole Docker Setup with Macvlan Networking

This project sets up [Pi-hole](https://pi-hole.net/) using Docker Compose with a `macvlan` network, allowing your Pi-hole instance to behave like a separate device on your local network — perfect for network-wide ad blocking.

---

## 📁 Directory Structure

```
.
├── docker-compose.yml      # Docker Compose file for Pi-hole
├── setup.sh                # Setup script to create macvlan and run Pi-hole
├── etc-pihole/             # Persistent Pi-hole config
└── etc-dnsmasq.d/          # Persistent DNSMasq config
```

---

## ⚙️ Prerequisites

* Docker and Docker Compose installed
* A physical network interface (e.g., `ens32`) that is connected to your local network
* Your system is on a Linux-based OS that supports `macvlan`

---

## 🛠️ Setup Instructions

1. **Edit the `setup.sh` file** to set your desired interface name (replace `ens32` if needed):

   ```bash
   -o parent=ens32 \
   ```

2. **Run the pihole script**:

   ```bash
   chmod +x pihole.sh
   ./pihole.sh
   ```

   This will:

   * Create a `macvlan` network named `pihole_macvlan` (if it doesn't exist)
   * Start the Pi-hole container using Docker Compose

---

## 🐳 Docker Compose Configuration

Key details from `docker-compose.yml`:

* **Image**: `pihole/pihole:latest`
* **Web Admin Password**: Set via `WEBPASSWORD`
* **DNS**: Uses Google DNS (`8.8.8.8`, `8.8.4.4`) and Pi-hole’s own resolver
* **Network**: Static IP `<your_ip>` on the `pihole_macvlan` network

Make sure this IP is free on your network and doesn't conflict with other devices.

---

## 🌐 Accessing Pi-hole

Once the container is running, access the Pi-hole admin interface at:

```
http://<your_ip>/admin
```

Login using the password defined in `docker-compose.yml` (`WEBPASSWORD`).

---

## 🧽 Cleanup

To stop and remove everything:

```bash
docker compose down
```

To delete the `macvlan` network:

```bash
docker network rm pihole_macvlan
```

---

## 📝 Notes

* The `macvlan` network makes Pi-hole accessible as if it were a separate device.
* You cannot directly access Pi-hole from the host machine due to macvlan isolation.

  * To test or use Pi-hole from the host, consider using a separate virtual interface or another device on the same network.

