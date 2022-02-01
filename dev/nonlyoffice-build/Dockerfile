# hadolint ignore=DL3007
FROM ghcr.io/truecharts/ubuntu:latest@sha256:8fdfa248ccf92903813d10319246be90ab62953c29cdbfc825cfc2498f5156ed

ENV TZ=Etc/UTC

ARG TARGETPLATFORM
ARG VERSION
ARG PACKAGE_URL="https://github.com/ONLYOFFICE/DocumentServer/releases/download/v${VERSION}/onlyoffice-documentserver_amd64.deb"

USER root

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
  apt-get -y update && \
  apt-get -y install gnupg ca-certificates curl lsb-release python python3 sudo git && \
  git clone --depth=1 --recursive https://github.com/NONLYOFFICE/build_tools.git /build_tools && \
  rm /usr/bin/python && ln -s /usr/bin/python2 /usr/bin/python

WORKDIR /build_tools

CMD cd tools/linux && \
    python3 ./automate.py
