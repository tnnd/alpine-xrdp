FROM danielguerra/alpine-sshdx:3.4


ADD apk /tmp/apk
RUN cp /tmp/apk/.abuild/-57cfc5fa.rsa.pub /etc/apk/keys

RUN apk --update --no-cache add xrdp xvfb alpine-desktop xfce4 thunar-volman openssh \
faenza-icon-theme slim xf86-input-synaptics xf86-input-mouse xf86-input-keyboard \
setxkbmap sudo util-linux dbus wireshark ttf-freefont xauth supervisor py-pip git \
docker docker-registry
RUN apk add /tmp/apk/ossp-uuid-1.6.2-r0.apk \
&& apk add /tmp/apk/ossp-uuid-dev-1.6.2-r0.apk \
&& apk add /tmp/apk/x11vnc-0.9.13-r0.apk \
&& rm -rf /tmp/* /var/cache/apk/*

ENV DOCKER_COMPOSE_VERSION 1.8.0
ENV COMPOSE_API_VERSION=1.18

RUN pip install --upgrade pip &&\
    pip install -U docker-compose==${DOCKER_COMPOSE_VERSION} &&\
    rm -rf /tmp/* /var/cache/apk/*

ADD etc /etc

RUN xrdp-keygen xrdp auto
RUN sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini \
&& sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini

EXPOSE 3389 22
#WORKDIR /home/alpine
#USER alpine
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/usr/bin/supervisord","-c","/etc/supervisord.conf"]
