# Configuration of nginx reverse proxy

### Download and install nginx, then check if its running
> apt install nginx
> nginx -t
> systemctl status nginx

### Create dedicated proxy server config for each web app
> nano /etc/nginx/sites-available/<name>
```
server {
    listen 80;
    server_name jumper.andrzej.site;

    location / {
        proxy_pass http://<socket>/<optional-resource-location>/;

        proxy_http_version 1.1;

        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}
```

### Enable configuration, by creating symbolic link
> ln -s /etc/nginx/sites-available/<name> /etc/nginx/sites-enabled/<name>

### Test config and reload nginx service
> nginx -t
> systemctl reload nginx

##### When using nginx as reverse proxy to fetch traffic through cloudflared, don't use HTTPS, as TLS is terminated by Cloudflare.
