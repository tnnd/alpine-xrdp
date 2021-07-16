FROM alpine:3.12

RUN apk --update --no-cache add xrdp xvfb xfce4 openssh x11vnc dbus util-linux bash \
	faenza-icon-theme slim xauth xf86-input-synaptics sudo supervisor firefox-esr xterm
RUN rm -rf /tmp/* /var/cache/apk/*

ADD etc /etc

# RUN xrdp-keygen xrdp auto
RUN sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini \
&& sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini

RUN addgroup alpine
RUN adduser  -G alpine -s /bin/sh -D alpine \
	&& echo "alpine:alpine" | /usr/sbin/chpasswd \
	&& echo "alpine    ALL=(ALL) ALL" >> /etc/sudoers \
	&& ssh-keygen -A

EXPOSE 3389 22
#USER alpine
#ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/usr/bin/supervisord","-c","/etc/supervisord.conf"]
