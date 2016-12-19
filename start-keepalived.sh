#!/bin/sh
set -e


echo "=> Configuring Keepalived"

sed -i -e "s/<--ROUTERID-->/${ROUTERID}/g" /etc/keepalived/keepalived.conf
sed -i -e "s/<--VROUTERID-->/${VROUTERID}/g" /etc/keepalived/keepalived.conf

sed -i -e "s/<--VIP-->/${VIP}/g" /etc/keepalived/keepalived.conf
sed -i -e "s/<--MASK-->/${MASK}/g" /etc/keepalived/keepalived.conf
sed -i -e "s/<--STATE-->/${STATE}/g" /etc/keepalived/keepalived.conf
sed -i -e "s/<--INTERFACE-->/${INTERFACE}/g" /etc/keepalived/keepalived.conf
sed -i -e "s/<--PRIORITY-->/${PRIORITY}/g" /etc/keepalived/keepalived.conf
sed -i -e "s/<--ADVERT-->/${ADVERT}/g" /etc/keepalived/keepalived.conf
sed -i -e "s/<--AUTHPASS-->/${AUTHPASS}/g" /etc/keepalived/keepalived.conf

sed -i -e "s/<--NOTIFIEMAILTO-->/${NOTIFIEMAILTO}/g" /etc/keepalived/keepalived.conf
sed -i -e "s/<--NOTIFIEMAILFROM-->/${NOTIFIEMAILFROM}/g" /etc/keepalived/keepalived.conf
sed -i -e "s/<--SMTPSERV-->/${SMTPSERV}/g" /etc/keepalived/keepalived.conf

echo "=> Starting Keepalived ... : "

echo "haproxy config"
cat /docker-lb/haproxy.cfg

# ##logging to /var/log/syslog
# service rsyslog start
# touch /var/log/haproxy.log
# chown syslog:adm /var/log/haproxy.log



exec /usr/sbin/keepalived --dont-fork --log-console -f /etc/keepalived/keepalived.conf
