#!/usr/bin/env bash

set -euo pipefail

echo "== Docker =="
docker info >/dev/null
echo "Docker: OK"

echo
echo "== Portainer container =="
docker inspect -f '{{.State.Status}}' portainer

echo
echo "== Portainer HTTPS =="
curl -k -fsS https://127.0.0.1:9443/ >/dev/null
echo "Portainer: OK"

echo
echo "Health check completed successfully."
