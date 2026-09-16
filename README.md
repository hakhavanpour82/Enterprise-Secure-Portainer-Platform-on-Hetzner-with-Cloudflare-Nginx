# Enterprise Secure Portainer Infrastructure

A production-oriented infrastructure project demonstrating the deployment of a private Docker and Portainer management platform on Hetzner Cloud, protected by Cloudflare and exposed through an Nginx reverse proxy.

The architecture separates the public ingress layer from the private Docker management environment and provides controlled outbound internet connectivity for the private server.

> **Note:** This repository is a sanitized portfolio implementation. Real credentials, private keys, tokens, production IP addresses, and other sensitive infrastructure data are intentionally excluded.

---

## Architecture

```
                         Internet
                            │
                            ▼
                    ┌────────────────┐
                    │   Cloudflare   │
                    │ DNS + Proxy    │
                    │ Full (strict)  │
                    └───────┬────────┘
                            │ HTTPS
                            ▼
                    ┌────────────────┐
                    │ Nginx Gateway  │
                    │ Public +       │
                    │ Private NIC    │
                    └───────┬────────┘
                            │
                    Hetzner Private Network
                         10.0.0.0/16
                            │
                            ▼
                    ┌────────────────┐
                    │ client-docker  │
                    │ Private Only   │
                    │ Docker Engine  │
                    └───────┬────────┘
                            │
                            ▼
                    ┌────────────────┐
                    │   Portainer    │
                    │     :9443      │
                    └────────────────┘
```

---

## Project Goals

* Deploy Docker and Portainer on a private server
* Keep the Docker management server off the public internet
* Provide controlled outbound internet access through a dedicated gateway
* Terminate public HTTPS traffic at Nginx
* Use Cloudflare as the public DNS and proxy layer
* Use Cloudflare Origin CA certificates between Cloudflare and Nginx
* Use Cloudflare `Full (strict)` TLS mode
* Reverse proxy Portainer over the private network
* Keep infrastructure configuration reproducible and documented
* Apply enterprise-oriented security and operational practices

---

## Technology Stack

| Component            | Technology              |
| -------------------- | ----------------------- |
| Cloud                | Hetzner Cloud           |
| DNS / CDN / Proxy    | Cloudflare              |
| Reverse Proxy        | Nginx                   |
| Container Runtime    | Docker Engine           |
| Container Management | Portainer CE            |
| Network              | Hetzner Private Network |
| TLS                  | Cloudflare Origin CA    |
| OS                   | Ubuntu Server           |
| Configuration        | YAML / Bash             |
| Deployment           | Docker Compose          |

---

## Network Design

Example sanitized addressing:

| Host            | Role                        | Private IP | Public IP |
| --------------- | --------------------------- | ---------: | --------- |
| `nginx-gateway` | Reverse proxy / NAT gateway | `10.0.0.2` | Public    |
| `client-docker` | Docker / Portainer          | `10.0.0.3` | None      |

Private network:

```
10.0.0.0/16
```

The Docker server does not require a public IP.

Outbound internet connectivity is provided through the gateway using network routing and NAT.

---

## Traffic Flow

### Inbound

```
Client
  │
  ▼
Cloudflare
  │
  │ HTTPS
  ▼
Nginx Gateway
  │
  │ Private Network
  ▼
Portainer
```

### Outbound

```
Portainer / Docker Host
          │
          ▼
Hetzner Private Network
          │
          ▼
Nginx Gateway
          │
         NAT
          │
          ▼
       Internet
```

---

## TLS Architecture

Cloudflare terminates the public-facing TLS connection and establishes a second TLS connection to the Nginx origin.

Cloudflare SSL/TLS mode:

```
Full (strict)
```

An Origin CA certificate is installed on the Nginx gateway.

The Portainer backend uses HTTPS on port `9443`.

The Nginx reverse proxy communicates with Portainer over the private network.

---

## Portainer Deployment

Portainer is deployed using Docker Compose.

The Docker socket is mounted into the Portainer container to allow management of the local Docker Engine.

The production configuration is intentionally sanitized before being committed to this repository.

---

## Security Model

The design follows a layered security approach:

1. Cloudflare provides the public DNS and proxy layer.
2. The Docker management server has no public IP.
3. Nginx is the only public ingress component.
4. Portainer is reachable through the private network.
5. HTTPS is used for external access.
6. Cloudflare Origin CA is used for origin authentication.
7. Credentials and private keys are excluded from source control.
8. Firewall rules are intended to restrict unnecessary traffic.
9. Infrastructure changes are documented and reproducible.

---

## Repository Structure

```text
.
├── README.md
├── ARCHITECTURE.md
├── SECURITY.md
├── NETWORK.md
├── DEPLOYMENT.md
├── OPERATIONS.md
├── docker/
│   └── compose.yml
├── nginx/
│   └── portainer.conf.example
├── scripts/
│   ├── backup.sh
│   └── health-check.sh
└── docs/
```

---

## Deployment Overview

The deployment process consists of:

1. Provision Hetzner servers
2. Create a private Hetzner Network
3. Attach the gateway and Docker server
4. Configure private networking
5. Configure outbound NAT through the gateway
6. Install Docker Engine
7. Deploy Portainer using Docker Compose
8. Configure Cloudflare DNS
9. Create an Origin CA certificate
10. Configure Nginx reverse proxy
11. Configure Cloudflare `Full (strict)`
12. Initialize Portainer
13. Verify the complete traffic path
14. Apply firewall and hardening controls

Detailed procedures are documented separately.

---

## Validation

The deployment was validated at multiple layers:

### Network

```
Docker Host → Internet
Docker Host → Private Gateway
Gateway → Docker Host
```

### Docker

```
Docker Engine
Docker Compose
Container lifecycle
Image pull
```

### Portainer

```
Portainer HTTPS :9443
Local Docker Environment
Docker socket connectivity
```

### Reverse Proxy

```
Cloudflare
    ↓
Nginx
    ↓
Portainer
```

---

## Operational Principles

This project follows several infrastructure-as-code and operations principles:

* Infrastructure should be reproducible
* Secrets should never be committed
* Public exposure should be minimized
* Network boundaries should be explicit
* Configuration should be version controlled
* Changes should be validated incrementally
* Monitoring and health checks should be automated
* Backup and recovery procedures should be documented

---

## Disclaimer

This repository is a portfolio implementation inspired by enterprise infrastructure patterns.

It does not contain confidential company information, production credentials, private keys, customer data, or proprietary configuration.

Actual production deployments should be adapted to the organization's security policies, compliance requirements, threat model, and operational standards.

---

## Author

Infrastructure / DevOps portfolio project demonstrating:

* Cloud Infrastructure
* Linux Administration
* Docker
* Portainer
* Nginx
* Cloudflare
* Private Networking
* NAT
* TLS
* Infrastructure Security
* Operational Documentation
