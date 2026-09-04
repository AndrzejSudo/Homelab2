# Configuration of cloudflare tunnel running on lxc container

### Download and install official cloudflare tunnel client:
> wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
> sudo apt install ./cloudflared-linux-amd64.deb

### Auth with cloudflare account (store creds in /root/.cloudflared/):
> cloudflared tunnel login

### Create tunnel (id and json cred file):
> cloudflared tunnel create <tunnel-name>

### Create config file:
> nano /root/.cloudflared/tunnel-config.yml

### Add DNS route:
> cloudflared tunnel route dns <tunnel-name> <domain.pl>

### Run tunnel:
> cloudflared tunnel run <tunnel-name)

### Make cloudflared run as a service:
> sudo systemctl enable cloudflared
> sudo systemctl start cloudflared

### Check connectivity
> cloudflared tunnel list
> ss -lnup | grep "cloudflared"

