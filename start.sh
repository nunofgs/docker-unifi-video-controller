#!/bin/bash

# This system.properties file would normally be laid down by the debian package
#  installer, but as we expect the user to overlay an external volume onto 
#  /var/lib/unifi-video it will be empty on first container start so we need
#  to fill it in ourselves.
if [ ! -f /var/lib/unifi-video/system.properties ]; then
    echo "is_default=true" > /var/lib/unifi-video/system.properties
fi

# We don't want the process to daemonize because we want it to run forever
# as the docker container process.
echo "UFV_DAEMONIZE=false" > /etc/default/unifi-video

# Fix an issue on our base image that doesn't create the logs directory.
mkdir -p /var/log/unifi-video

# Install and convert a let's encrypt certificate, if provided.
if [ -n "$CERTIFICATE" ]; then
  mkdir -p /var/lib/unifi-video/certificates/

  openssl x509 -outform der -in "/etc/letsencrypt/production/certs/${CERTIFICATE}/fullchain.pem" -out /var/lib/unifi-video/certificates/ufv-server.cert.der
  openssl pkcs8 -topk8 -inform PEM -outform DER -nocrypt -in "/etc/letsencrypt/production/certs/${CERTIFICATE}/privkey.pem" -out /var/lib/unifi-video/certificates/ufv-server.key.der
fi

/usr/sbin/unifi-video start --debug
