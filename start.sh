#!/bin/bash -ex

# Install and convert a let's encrypt certificate, if provided.
if [ -d "/etc/certificates" ]; then
  rm -rf /var/lib/unifi-video/{certificates,keystore,ufv-truststore}
  mkdir -p /var/lib/unifi-video/certificates/

  openssl x509 -outform der -in "/etc/certificates/fullchain.pem" -out /var/lib/unifi-video/certificates/ufv-server.cert.der
  openssl pkcs8 -topk8 -inform PEM -outform DER -nocrypt -in "/etc/certificates/privkey.pem" -out /var/lib/unifi-video/certificates/ufv-server.key.der
fi

exec /run.sh
