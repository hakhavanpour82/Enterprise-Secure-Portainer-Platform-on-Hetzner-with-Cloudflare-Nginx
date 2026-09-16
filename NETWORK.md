# Network Design

## Addressing

The project uses a dedicated private network.

Example:

```
Network: 10.0.0.0/16
```

Example hosts:

```
Gateway:      10.0.0.2
Docker Host:  10.0.0.3
```

These addresses are examples and should be replaced with environment-specific values.

## Routing

The Docker host uses the Hetzner network gateway for private network connectivity.

The private network routes outbound traffic through the dedicated gateway.

```
Docker Host
    │
    ▼
Hetzner Network Gateway
    │
    ▼
Nginx Gateway
    │
    ▼
NAT
    │
    ▼
Internet
```

## NAT

The gateway performs source NAT for private network traffic that requires internet access.

This allows the private Docker host to:

* Pull Docker images
* Resolve DNS
* Access external repositories
* Perform operating system updates

without requiring a public IP address.

## Inbound Traffic

Internet traffic follows:

```
Internet
   ↓
Cloudflare
   ↓
Nginx Gateway
   ↓
Private Network
   ↓
Portainer
```

Portainer is not directly exposed through a public IP.

## Verification

Useful checks:

```bash
ip addr
ip route
ping 10.0.0.2
ping 8.8.8.8
resolvectl status
```

NAT verification:

```bash
sysctl net.ipv4.ip_forward
iptables -t nat -L POSTROUTING -n -v
```

## Security Considerations

The private network should not be considered automatically trusted.

Firewall rules should restrict:

* Administrative access
* Management ports
* Inter-server communication
* Unnecessary outbound traffic

Detailed firewall policy should be maintained separately.
