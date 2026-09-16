# Operations

## Health Checks

Docker:

```bash
docker ps
docker info
```

Portainer:

```bash
docker compose ps
docker logs --tail 50 portainer
```

Nginx:

```bash
systemctl status nginx
nginx -t
```

Network:

```bash
ip route
resolvectl status
```

## Logs

Portainer:

```bash
docker logs portainer
```

Nginx:

```bash
journalctl -u nginx
```

## Updates

Before updating:

1. Review release notes
2. Create backups
3. Verify current configuration
4. Update in a controlled window
5. Validate application health

## Backup

Important Portainer data should be backed up regularly.

The backup strategy should include:

* Portainer configuration
* Portainer database
* Docker Compose files
* Infrastructure configuration
* TLS certificate metadata where appropriate

Private keys must be stored securely and separately from Git.

## Recovery

A recovery procedure should verify:

1. Server availability
2. Network connectivity
3. Docker Engine
4. Portainer data
5. Reverse proxy
6. TLS
7. DNS
8. Application availability

## Change Management

Infrastructure changes should follow:

```
Plan
  ↓
Backup
  ↓
Change
  ↓
Validate
  ↓
Document
```

## Monitoring Roadmap

Recommended future additions:

* Uptime monitoring
* CPU / RAM / disk monitoring
* Container health checks
* Nginx metrics
* Centralized logs
* Alerting
* Certificate expiration monitoring
