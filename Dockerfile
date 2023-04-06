# use a builder image for building cloudflare
FROM golang:1.19 as builder
ARG TARGET_GOOS \
    TARGET_GOARCH \
    GIT_TAG
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    TARGET_GOOS=${TARGET_GOOS} \
    TARGET_GOARCH=${TARGET_GOARCH}

LABEL org.opencontainers.image.source="https://github.com/cloudflare/cloudflared"

WORKDIR /go/src/github.com/cloudflare/cloudflared/

# compile cloudflared from latest tag
RUN git clone --depth=1 "https://github.com/cloudflare/cloudflared" . && \
    git switch -c "${GIT_TAG}" && \
    make cloudflared

# use an empty image, and rely on GoLang to manage binaries
FROM scratch

WORKDIR /local/usr/bin/
ENV PATH=/local/usr/bin/

LABEL org.opencontainers.image.source="https://github.com/cloudflare/cloudflared"

COPY --from=builder /go/src/github.com/cloudflare/cloudflared/cloudflared .
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

ENTRYPOINT ["cloudflared", "--no-autoupdate"]
CMD ["version"]
