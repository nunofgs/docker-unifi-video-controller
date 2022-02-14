#!/bin/bash -ex

# Install and convert a let's encrypt certificate, if provided.
if [ -d "/etc/certificates" ]; then
  newHash=$(md5sum /etc/certificates/privkey.pem | cut -f1 -d ' ')

  # Retrieve existing hash.
  if [ -f /var/lib/unifi-video/certificates/md5.lock ]; then
    existingHash=$(cat /var/lib/unifi-video/certificates/md5.lock)
  fi

  # If hash is not the same, then update the certificates.
  if [ "${newHash}" != "${existingHash}" ]; then
    rm -rf /var/lib/unifi-video/{cam-keystore,certificates,keystore,ufv-truststore}
    mkdir -p /var/lib/unifi-video/certificates/

    openssl x509 -outform der -in "/etc/certificates/fullchain.pem" -out /var/lib/unifi-video/certificates/ufv-server.cert.der
    openssl pkcs8 -topk8 -inform PEM -outform DER -nocrypt -in "/etc/certificates/privkey.pem" -out /var/lib/unifi-video/certificates/ufv-server.key.der

    chown -R $PUID:$PGID /var/lib/unifi-video/certificates/

    echo "$newHash" > /var/lib/unifi-video/certificates/md5.lock
  fi
fi

exec /run.sh
