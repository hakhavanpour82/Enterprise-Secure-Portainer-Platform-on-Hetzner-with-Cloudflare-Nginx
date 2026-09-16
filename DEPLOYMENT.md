# Deployment Guide

## Prerequisites

* Hetzner Cloud account
* Cloudflare-managed domain
* Ubuntu Server
* Docker Engine
* Docker Compose
* Private network
* Public gateway server

## Deployment Flow

### 1. Create Private Network

Create a dedicated private network, for example:

```
10.0.0.0/16
```

### 2. Provision Gateway

The gateway requires:

* Public IP
* Private network interface

Install Nginx.

### 3. Provision Docker Host

The Docker host should use:

* Private IP
* No public IP

Install:

* Docker Engine
* Docker Compose

### 4. Configure Routing

Configure the private network routing so outbound traffic can use the gateway.

### 5. Configure NAT

Enable IPv4 forwarding:

```bash
sysctl net.ipv4.ip_forward
```

Configure appropriate NAT rules on the gateway.

### 6. Deploy Portainer

Example:

```bash
mkdir -p /opt/portainer
cd /opt/portainer
docker compose up -d
```

### 7. Configure Cloudflare

Create:

```
portainer.<domain>
```

pointing to the public gateway.

Enable Cloudflare proxying.

### 8. Configure Origin TLS

Create an Origin CA certificate and install it on Nginx.

Do not commit the private key.

### 9. Configure Nginx

Configure Nginx to proxy:

```
https://portainer.<domain>
        ↓
https://PRIVATE_PORTAINER_IP:9443
```

### 10. Enable Full Strict

Cloudflare SSL/TLS mode:

```
Full (strict)
```

### 11. Initialize Portainer

Open:

```
https://portainer.<domain>
```

Create the initial administrator.

Never store the administrator password in Git.

## Validation

Validate each layer independently:

```bash
docker ps
docker compose ps
curl -k https://127.0.0.1:9443
```

Then validate the reverse proxy and public hostname.

## Rollback

Before infrastructure changes:

* Back up configuration
* Validate syntax
* Keep previous configuration available
* Apply changes incrementally

For Nginx:

```bash
nginx -t
systemctl reload nginx
```

Avoid restarting production services unnecessarily.
