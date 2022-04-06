ARG VERSION

FROM ghcr.io/k8s-at-home/ubuntu:v${VERSION}

ARG TARGETPLATFORM

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

RUN \
  mkdir /custom
  chown -R apps:apps /custom 
  chmod -R 777 /custom
  usermod -l apps kah \
  && \
  groupmod -n apps kah \
  && chown -R apps:apps /config

COPY ./base/ubuntu/shim/greeting.sh /shim/greeting.sh
COPY ./base/ubuntu/shim/steppingstone.sh /shim/steppingstone.sh

WORKDIR /app

USER apps

VOLUME [ "/config" ]


COPY ./base/ubuntu/entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/shim/steppingstone.sh" ]

LABEL "maintainer"="TrueCharts <info@truecharts.org>"
LABEL "org.opencontainers.image.source"="https://github.com/truecharts/apps"
