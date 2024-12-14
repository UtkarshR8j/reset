#!/bin/bash

# Ensure script is run with elevated privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or use sudo"
  exit 1
fi

# Update the system
echo "Updating system..."
sudo yum update -y

# Install Docker from Amazon Linux Extras
echo "Installing Docker..."
sudo amazon-linux-extras install docker -y
sudo yum install docker -y

# Start Docker service
echo "Starting Docker service..."
sudo service docker start

# Add ec2-user to the Docker group
echo "Adding ec2-user to the Docker group..."
sudo usermod -aG docker ec2-user

echo "Docker installation complete. Please logout and log back in to verify."

# Display Docker info (will only work after logout and login)
echo "Verifying Docker installation..."
docker info || echo "Please logout and log back in, then re-run 'docker info' to verify."

# Install Docker Compose
echo "Installing Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Display Docker Compose version
echo "Docker Compose version:"
docker-compose version
