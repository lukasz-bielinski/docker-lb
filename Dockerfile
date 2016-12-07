FROM oberthur/docker-ubuntu:16.04
MAINTAINER Lukasz Bielinski <l.bielinski@oberthur.com>


ENV KEEPALIVED_VERSION=1:1.2.23~ubuntu16.04.1
ENV HAPROXY_VERSION=1.7.0-1ppa1~xenial

COPY start-keepalived.sh /bin/start-keepalived.sh
COPY notifyscript.sh /bin/notifyscript.sh

# Prepare image
RUN chmod +x /bin/start-keepalived.sh \
    && chmod +x /bin/notifyscript.sh \
    && add-apt-repository ppa:keepalived/stable \
    && add-apt-repository ppa:vbernat/haproxy-1.7 \
    && apt-get update \
    && apt-get install rsyslog keepalived=$KEEPALIVED_VERSION haproxy=$HAPROXY_VERSION ssh\
    && apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/ \
    && apt-cache policy  haproxy keepalived


COPY 49-haproxy.conf /etc/rsyslog.d/49-haproxy.conf
COPY rsyslog.conf /etc/rsyslog.conf

COPY keepalived.conf /etc/keepalived/keepalived.conf
COPY check_haproxy.sh /usr/local/bin/check_haproxy.sh

RUN chmod +x /usr/local/bin/check_haproxy.sh

ENTRYPOINT ["/bin/start-keepalived.sh"]
