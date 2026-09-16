# Security

## Security Objectives

The platform is designed around:

* Reduced public attack surface
* Network segmentation
* TLS encryption
* Controlled ingress
* Controlled outbound connectivity
* Secret isolation
* Minimal service exposure

## Public Exposure

The Docker/Portainer server has no public IP address.

The public ingress point is the Nginx gateway.

## TLS

External traffic uses HTTPS.

Cloudflare operates in:

```
Full (strict)
```

An Origin CA certificate is installed on the Nginx gateway.

## Secrets

The following must never be committed:

* Private keys
* Passwords
* API tokens
* Cloudflare credentials
* Portainer setup tokens
* SSH private keys
* Database credentials
* `.env` files containing secrets

Use placeholders in committed configuration examples.

## Example

Do not commit:

```
CLOUDFLARE_API_TOKEN=real-token
```

Use:

```
CLOUDFLARE_API_TOKEN=<REPLACE_WITH_SECRET>
```

## Hardening Roadmap

Recommended controls include:

* Host firewall
* SSH key authentication
* Disable password authentication
* Restrict SSH source addresses
* Restrict public ports
* TLS 1.2 / TLS 1.3 only
* Security headers
* Automatic security updates
* Centralized logging
* Monitoring
* Backups
* Restore testing
* Secret rotation

## Incident Response

If a credential is accidentally committed:

1. Revoke the credential immediately.
2. Generate a replacement credential.
3. Remove the secret from repository history where appropriate.
4. Audit access logs.
5. Document the incident.

Removing a secret from Git history alone does not make the original credential safe.
