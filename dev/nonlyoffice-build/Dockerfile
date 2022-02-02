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
  apt-get -y install \
  gnupg \
  ca-certificates \
  curl \
  lsb-release \
  python \
  python3 \
  sudo \
  git \
  apt-transport-https \
  autoconf2.13 \
  build-essential \
  ca-certificates \
  cmake \
  curl \
  git \
  glib-2.0-dev \
  libglu1-mesa-dev \
  libgtk-3-dev \
  libpulse-dev \
  libtool \
  p7zip-full \
  subversion \
  gzip \
  libasound2-dev \
  libatspi2.0-dev \
  libcups2-dev \
  libdbus-1-dev \
  libicu-dev \
  libglu1-mesa-dev \
  libgstreamer1.0-dev \
  libgstreamer-plugins-base1.0-dev \
  libx11-xcb-dev \
  libxcb* \
  libxi-dev \
  libxrender-dev \
  libxss1 \
  libncurses5 \
  nodejs \
  npm \
  yarn \
  openjdk-11-jdk \
  && \
  git clone --depth=1 --recursive https://github.com/NONLYOFFICE/build_tools.git /build_tools && \
  rm /usr/bin/python && ln -s /usr/bin/python2 /usr/bin/python

WORKDIR /build_tools

CMD cd tools/linux && \
    python3 ./automate.py
