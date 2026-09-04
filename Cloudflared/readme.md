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
> cloudflared tunnel route dns <tunnel-name> <domain.com>

### Run tunnel:
> cloudflared tunnel run <tunnel-name)

### Make cloudflared run as a service:
> sudo systemctl enable cloudflared
> sudo systemctl start cloudflared

### Check connectivity
> cloudflared tunnel list
> ps aux | grep "cloudflared"
> ss -lnup | grep "cloudflared"
> curl -k <domain.com>
> journalctl -u cloudflared -n 100 --no-pager


Different tunnels can run from same container, just need separate creds/config files and systemd service f.e: /etc/systemd/system/cloudflared2.service
Multiple tunnels can also use same credentials and config file, but better split them for redundancy and if they are using different domain
