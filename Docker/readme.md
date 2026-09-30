# Configuration for docker setup on ubuntu server

### Remove old packages, update and install dependencies
> sudo apt remove docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc
> sudo apt update
> sudo apt install ca-certificates curl

### Add docker gpg key and repo
> sudo install -m 0755 -d /etc/apt/keyrings
> sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
> sudo chmod a+r /etc/apt/keyrings/docker.asc

