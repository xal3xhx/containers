# hadolint ignore=DL3007
FROM quay.io/helmpack/chart-releaser:v1.4.0@sha256:f9e6b06a1d60bcd94a2a6a4988a59233936239347c69b4ab2d99916ffc848a5b AS cr

# hadolint ignore=DL3007
FROM jnorwood/helm-docs:v1.9.1@sha256:622b9cde189fa6f8c1dbb3692dbea6f7816e078cd5fcfa042fe0d859077c6ea7 AS hd

# hadolint ignore=DL3007
FROM quay.io/git-chglog/git-chglog:0.15.1@sha256:471db4cefc1a4dc0d8ee996447d5ac860f9496c982bcd29e90b390aff4e78175 AS gcl

# hadolint ignore=DL3007
FROM ixsystems/catalog_validation:latest@sha256:0bccbfae4fcbce4fd0c47f92b6a827750f2f715347b1010fc7084430485659b5

ARG TARGETPLATFORM
ARG VERSION

USER root

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008,DL3015,SC2086,SC2155
RUN --mount=type=bind,from=cr,source=/usr/local/bin,target=/crbin \
  cp /crbin/cr /usr/local/bin/cr

# hadolint ignore=DL3008,DL3015,SC2086,SC2155
RUN --mount=type=bind,from=hd,source=/usr/bin/,target=/hdbin \
  cp /hdbin/helm-docs /usr/local/bin/helm-docs

# hadolint ignore=DL3008,DL3015,SC2086,SC2155
RUN --mount=type=bind,from=gcl,source=/usr/local/bin,target=/gclbin \
  cp /gclbin/git-chglog /usr/local/bin/git-chglog

COPY ./.pre-commit-config.yaml /app/.pre-commit-config.yaml

# hadolint ignore=DL3008,DL3015,SC2086,SC2155,DL3013
RUN pip install --no-cache-dir pre-commit && \
  git init . && \
  pre-commit install-hooks && \
  rm -Rf /App/* && \
  echo "installed pre-commit hooks:" && \
  ls ~/.cache/pre-commit/*


LABEL "maintainer"="TrueCharts <info@truecharts.org>"
LABEL "org.opencontainers.image.source"="https://github.com/truecharts/apps"
