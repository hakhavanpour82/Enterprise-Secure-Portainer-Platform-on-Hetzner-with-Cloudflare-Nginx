# Architecture

## Overview

The platform uses a two-tier infrastructure model:

* Public ingress layer
* Private application and container management layer

The separation reduces the public attack surface and allows the Docker management environment to remain isolated from direct internet access.

## Components

### Nginx Gateway

Responsibilities:

* Public HTTPS termination
* Reverse proxy
* Private network connectivity
* Controlled outbound NAT
* TLS certificate handling

### Docker Server

Responsibilities:

* Docker Engine
* Docker Compose
* Portainer
* Application containers

The server does not have a public IP address.

### Cloudflare

Responsibilities:

* DNS
* Reverse proxy
* Public TLS termination
* Origin TLS validation
* DDoS protection provided by the Cloudflare edge

## Network Segmentation

```
Public Internet
      │
      ▼
Cloudflare
      │
      ▼
Public Gateway
      │
      │ Private Network
      ▼
Private Docker Host
```

## Security Boundaries

The main security boundary exists between the public gateway and the private Docker environment.

Portainer is not directly exposed to the internet.

Only the Nginx gateway acts as the public application entry point.

## Design Principles

* Least exposure
* Network segmentation
* Defense in depth
* Centralized ingress
* Explicit trust boundaries
* Separation of public and private workloads
* Reproducible configuration
* Secure secret management
