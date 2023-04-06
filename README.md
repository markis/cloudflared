# Cloudflare Tunnel client for ARM-based systems

Cloudflare publishes images for amd64/arm64, but they don't publish images for older raspberry pi's with arm/v7 or arm/v6 based systems. This project automatically builds cloudflared for arm based systems and publishes the images in the github container repository.

To pull this image:
```shell
docker pull ghcr.io/markis/cloudflared:latest
```

[Cloudflare Tunnel client docs](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps)
