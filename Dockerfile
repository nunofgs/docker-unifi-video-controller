FROM pducharme/unifi-video-controller:3.10.13

COPY start.sh /

CMD ["/start.sh"]
