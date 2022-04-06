# hadolint ignore=DL3007
FROM ghcr.io/truecharts/ubuntu:latest


ARG TARGETPLATFORM
ARG VERSION

ENV DATA_DIR="/data"
ENV STEAMCMD_DIR="${DATA_DIR}/steamcmd"
ENV SERVER_DIR="${DATA_DIR}/serverfiles"
ENV GAME_ID="template"
ENV GAME_NAME="template"
ENV GAME_PARAMS="template"
ENV GAME_PORT=27015
ENV VALIDATE=""
ENV UMASK=000
ENV UID=568
ENV GID=568
ENV USERNAME=""
ENV PASSWRD=""
ENV USER="apps"
ENV GROUP="apps"

USER root

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
COPY ./apps/steamcmd/scripts/ /${DATA_DIR}/scripts/

# hadolint ignore=DL3008,DL3015,SC2086,SC2155
RUN \
  apt-get -qq update && \
  apt-get -qq install -y --no-install-recommends lib32gcc-s1 lib32stdc++6 \
  && \
  case "${TARGETPLATFORM}" in \
    'linux/amd64') export ARCH='linux-x64' ;; \
  esac && \
  rm -rf /var/lib/apt/lists/* && \
  mkdir ${DATA_DIR} && \
  mkdir ${STEAMCMD_DIR} && \
  mkdir ${SERVER_DIR} && \
  chmod -R 770 /${DATA_DIR}/scripts/
  useradd -d ${DATA_DIR} -s /bin/bash ${USER} && \
  chown -R ${USER} ${DATA_DIR} && \
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && apt-get autoremove -y \
  && apt-get clean \
  && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/ \
  && chmod -R u=rwX,go=rX /app \
  && printf "umask %d" "${UMASK}" >> /etc/bash.bashrc \
  && update-ca-certificates


USER apps

COPY ./apps/steamcmd/scripts/start.sh /custom/start.sh
COPY ./apps/steamcmd/entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]

LABEL "maintainer"="TrueCharts <info@truecharts.org>"
LABEL "org.opencontainers.image.source"="https://github.com/truecharts/apps"
