#!/bin/bash
# Check if haproxy is running, return 1 if not.
# Used by keepalived to initiate a failover in case haproxy is down

HAPROXY_STATUS=$(curl --write-out %{http_code} --silent --output /dev/null 127.0.0.1:60001)

if [ "$HAPROXY_STATUS" = "200" ]
then
  echo "HAProxy is running properly."
  exit 0
else
  logger "HAProxy is NOT running. Setting keepalived state to FAULT."
  echo "HAProxy is NOT running. Setting keepalived state to FAULT."
  exit 1
fi
