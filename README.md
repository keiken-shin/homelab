# 🏡 Homelab Infrastructure

Welcome to my **Homelab** repository — a modular collection of self-hosted services and infrastructure configurations designed to improve privacy, performance, learning, and automation at home.

This repo provides clean, containerized setups using **Docker** and **Docker Compose**, organized into separate directories for easy management, version control, and portability.


---

## 📁 Repository Structure

Each service in this repo lives in its own directory with all the files needed for deployment, including its own `ABOUT.md` file for detailed instructions and configurations.

| Service Directory | Description                             | Docs Reference           |
|-------------------|-----------------------------------------|--------------------------|
| `pihole/`         | Network-wide ad blocker using Pi-hole, configured with macvlan for isolated networking | [📄 ABOUT.md](./pihole/ABOUT.md) |
| `nextcloud/`      | Nextcloud provides a self-hosted file sync and share platform, giving you complete control over your data. | [📄 ABOUT.md](./nextcloud/ABOUT.md) |

> 🔄 More directories and services will be added as the lab evolves.

---

## 🔧 Prerequisites

To deploy any of the services in this repository, make sure your system has the following installed and configured:

- [Docker](https://docs.docker.com/get-docker/) (v20.10 or newer recommended)
- [Docker Compose](https://docs.docker.com/compose/) (v2.0+ preferred)
- A Linux-based host machine (e.g., Ubuntu, Debian -> I prefer Ubuntu with minimized install)
- Basic knowledge of terminal commands
- Optional: A static IP address for the host if using macvlan networking (e.g., for Pi-hole)

Some services (e.g., Pi-hole with macvlan) may require elevated privileges and specific network configurations. Always read the `ABOUT.md` in each service directory before launching.

---

## 🚀 Getting Started

Each service is self-contained. To get started with one (e.g., Pi-hole):

```bash
cd pihole
./pihole.sh
```


---

## 📖 Backstory

It all started with an old **Lenovo ThinkCentre** a gift from my Father given to me when I was in 8th grade was sitting idle — a system with a **dual-core Intel CPU**, just **2 GB of RAM**, and a recently upgraded **2 TB hard disk**, but no GPU. The hardware wasn't suited for heavy graphical workloads or desktop computing anymore, so rather than letting it collect dust, I decided to **repurpose it into a lightweight homelab**, mostly serving as a **NAS and self-hosting platform**.

This setup is minimal but functional — proving that even modest hardware can host powerful, privacy-respecting services when paired with Linux, Docker, and some thoughtful configuration.


---