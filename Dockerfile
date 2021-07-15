FROM danielguerra/alpine-sshdx:3.8


ADD apk /tmp/apk
RUN cp /tmp/apk/.abuild/-58b7ee0c.rsa.pub /etc/apk/keys

RUN apk --update --no-cache add xrdp xvfb xfce4 openssh x11vnc dbus util-linux \
	faenza-icon-theme slim xauth xf86-input-synaptics ttf-freefont sudo supervisor
RUN rm -rf /tmp/* /var/cache/apk/*

ADD etc /etc

RUN xrdp-keygen xrdp auto
RUN sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini \
&& sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini

RUN echo "alpine    ALL=(ALL) ALL" >> /etc/sudoers

EXPOSE 3389 22
#WORKDIR /home/alpine
#USER alpine
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/usr/bin/supervisord","-c","/etc/supervisord.conf"]
