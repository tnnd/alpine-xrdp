# About

Alpine linux xfce4 rdp server with it's own docker server and docker-registry.

# Usage


## Server method 1, rdp behind openssh
Start the server
```bash
docker run -d --privileged --name rdp -p 4848:22 danielguerra/alpine-xrdp-dind
```

from you client
```bash
ssh -p 4848 -L 3389:127.0.0.1:3389 alpine@<docker-ip>
```

Connect with your favorite rdp client to 127.0.0.1 3389

## Server method 2, direct rdp

Start the server
```bash
docker run -d --privileged --name rdp -p 3389:3389 danielguerra/alpine-xrdp-dind
```

Connect with your favorite rdp client to <docker-ip> 3389

## Credentials

User: alpine
Pass: alpine

## In container usage

In a terminal in your rdp session
```bash
sudo wget http://myserver/docker-compose.yml
sudo docker-compose up -d
```
