# About

Alpine linux xfce4 rdp server with it's own docker server and docker-registry.

# Usage

Start the server
```bash
docker run -d --name rdp -p 4848:22 danielguerra/alpine-xrdp-dind
```

from you client
```bash
ssh -p 4848 -L 3389:127.0.0.1:3389 alpine@<docker-ip>
```

Connect with your favorite rdp client to 127.0.0.1 3389

User: alpine
Pass: alpine

In a terminal in your rdp session
```bash
sudo wget http://myserver/docker-compose.yml
sudo docker-compose up -d
```
