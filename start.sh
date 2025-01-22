#!/bin/bash

# Laad variabelen uit .env
set -a
source .env
set +a

# Genereer de Caddyfile
echo "Generating Caddyfile with domain: $DOMAIN"
envsubst '${DOMAIN}' < Caddyfile.template > Caddyfile

# Start de Docker containers
echo "Starting Docker containers..."
docker compose up -d

echo "Done!"
