#!/bin/bash

# Stop het script bij een fout
set -e

# Update de package-index
echo "Updating package index..."
sudo apt-get update -y

# Installeren van vereiste pakketten
echo "Installing required packages..."
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    git

# Docker GPG-sleutel toevoegen
echo "Adding Docker's GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Docker repository toevoegen
echo "Adding Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Docker installeren
echo "Installing Docker..."
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Docker Compose installeren
echo "Installing Docker Compose..."
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4)
sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Controleer installaties
echo "Verifying Docker and Docker Compose installation..."
docker --version
docker-compose --version

# Repository clonen
REPO_URL="https://github.com/sweebee/soketi-docker.git"
TARGET_DIR="soketi-docker"

echo "Cloning repository $REPO_URL..."
if [ -d "$TARGET_DIR" ]; then
    echo "Directory $TARGET_DIR already exists. Skipping clone."
else
    git clone "$REPO_URL" "$TARGET_DIR"
fi

# .env.example kopiëren naar .env
echo "Copying .env.example to .env..."
cd "$TARGET_DIR"
if [ -f ".env" ]; then
    echo ".env file already exists. Skipping copy."
else
    cp .env.example .env
    echo ".env file created."
fi

echo "Setup complete."
