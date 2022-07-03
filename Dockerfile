FROM golang:alpine AS build
WORKDIR /
ARG HUGO_VERSION=0.101.0
RUN wget https://github.com/gohugoio/hugo/releases/download/v$HUGO_VERSION/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
    tar -xzf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
    rm -fr hugo_${HUGO_VERSION}_Linux-64bit.tar.gz

FROM        almir/webhook
COPY        --from=build /hugo /usr/local/bin/hugo
WORKDIR     /etc/webhook
VOLUME      ["/etc/webhook"]
EXPOSE      9000
ENTRYPOINT  ["/usr/local/bin/webhook"]
