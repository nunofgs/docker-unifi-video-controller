# Unifi Video Controller Docker container

This container will run the Unifi Video Controller software (NVR) and optionally configure custom letsencrypt certificates.

| Environment variables | Description                                                   |
|-----------------------|---------------------------------------------------------------|
| $CERTIFICATE          | The certificate name, stored in the `/etc/letsencrypt` folder |

| Mount points         | Description                                                  |
|----------------------|--------------------------------------------------------------|
| /etc/letsencrypt     | The volume where the let's encrypt certificates are stored   |
| /var/lib/unifi-video | The NVR data folder, which includes the database, logs, etc. |

# Usage

```shell
$ docker run \
  -p 1935:1935 \
  -p 6666:6666 \
  -p 7080:7080 \
  -p 7443:7443 \
  -p 7445:7445 \
  -p 7446:7446 \
  -p 7447:7447 \
  -v /opt/unifi/video:/var/lib/unifi-video \
  -v /opt/letsencrypt:/etc/letsencrypt:ro \
  nunofgs/unifi-video-controller
```

# Thanks

A special thank you to [supafyn/unifi-video-controller](github.com/supafyn/unifi-video-controller) which this container is based on.