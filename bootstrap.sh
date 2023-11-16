#!/bin/bash

# Install the HashiCorp GPG key
#wget -O- https://apt.releases.hashicorp.com/gpg | \
#gpg --dearmor | \
#tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Verify the key's fingerprint
#gpg --no-default-keyring \
#--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
#--fingerprint

#echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
#https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
#tee /etc/apt/sources.list.d/hashicorp.list

# Download the package information from HashiCorp
#apt update

# Install Terraform from the new repository
# sudo apt-get install terraform


#-------------------------------------------------------------------------------------------#
#-------------------------------------------------------------------------------------------#

# Dependences
apt-get update -y
#apt-get install -y gnupg software-properties-common

# Docker Install
#curl -fsSL https://get.docker.com -o get-docker.sh
#sudo sh ./get-docker.sh

#-------------------------------------------------------------------------------------------#
#                                       Kubernetes
#-------------------------------------------------------------------------------------------#
#URL
#https://kubernetes.io/es/docs/tasks/tools/included/install-kubectl-linux/
#Download Kubernetes
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
#Download the package for validate
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
#Validate the package
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
#Install
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
#Validate
kubectl version --client

#-------------------------------------------------------------------------------------------#
#                                       Docker
#-------------------------------------------------------------------------------------------#
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
#Install
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
#Verify
sudo docker run hello-world

Use Docker without sudo
sudo groupadd docker
sudo usermod -aG docker vagrant
newgrp docker