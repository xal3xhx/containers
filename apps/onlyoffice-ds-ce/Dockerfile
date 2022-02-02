# hadolint ignore=DL3007
FROM ghcr.io/truecharts/nonlyoffice-build:latest@sha256:df1b2ba585991594515fa058b3565636ac72bd518618559835bc9f5968f5c13d AS builder

USER root

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV PRODUCT_VERSION='7.0.0' BUILD_NUMBER='132' NODE_ENV='production'

RUN cd "/build_tools/tools/linux" && python3 ./automate.py server

RUN echo "/build_tools/out"

# hadolint ignore=DL3007
FROM ghcr.io/truecharts/ubuntu:latest@sha256:8fdfa248ccf92903813d10319246be90ab62953c29cdbfc825cfc2498f5156ed

ARG TARGETPLATFORM
ARG VERSION
ARG PACKAGE_URL="https://github.com/ONLYOFFICE/DocumentServer/releases/download/v${VERSION}/onlyoffice-documentserver_amd64.deb"

ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8 DEBIAN_FRONTEND=noninteractive PG_VERSION=12

USER root

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN --mount=type=bind,from=builder,source=/build_tools/out,target=/build_tools/out \
    echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d && \
    printf '#!/bin/sh\nexit 0' > /usr/sbin/policy-rc.d && \
    apt-get -y update && \
    apt-get -yq install wget apt-transport-https gnupg locales && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0x8320ca65cb2de8e5 && \
    locale-gen en_US.UTF-8 && \
    echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections && \
    apt-get -yq install \
        adduser \
        apt-utils \
        bomstrip \
        certbot \
        curl \
        gconf-service \
        htop \
        libasound2 \
        libboost-regex-dev \
        libcairo2 \
        libcurl3-gnutls \
        libcurl4 \
        libgtk-3-0 \
        libnspr4 \
        libnss3 \
        libstdc++6 \
        libxml2 \
        libxss1 \
        libxtst6 \
        mysql-client \
        nano \
        net-tools \
        netcat-openbsd \
        nginx-extras \
        postgresql \
        postgresql-client \
        pwgen \
        rabbitmq-server \
        redis-server \
        software-properties-common \
        sudo \
        supervisor \
        ttf-mscorefonts-installer \
        xvfb \
        zlib1g && \
    if [  $(ls -l /usr/share/fonts/truetype/msttcorefonts | wc -l) -ne 61 ]; \
        then echo 'msttcorefonts failed to download'; exit 1; fi  && \
    echo "SERVER_ADDITIONAL_ERL_ARGS=\"+S 1:1\"" | tee -a /etc/rabbitmq/rabbitmq-env.conf && \
    sed -i "s/bind .*/bind 127.0.0.1/g" /etc/redis/redis.conf && \
    sed 's|\(application\/zip.*\)|\1\n    application\/wasm wasm;|' -i /etc/nginx/mime.types && \
    pg_conftool $PG_VERSION main set listen_addresses 'localhost' && \
    service postgresql restart && \
    sudo -u postgres psql -c "CREATE DATABASE onlyoffice;" && \
    sudo -u postgres psql -c "CREATE USER onlyoffice WITH password 'onlyoffice';" && \
    sudo -u postgres psql -c "GRANT ALL privileges ON DATABASE onlyoffice TO onlyoffice;" && \ 
    service postgresql stop && \
    service redis-server stop && \
    service rabbitmq-server stop && \
    service supervisor stop && \
    service nginx stop && \
    rm -rf /var/lib/apt/lists/*

COPY ./apps/onlyoffice-ds-ce/config /app/ds/setup/config/

RUN wget -q -P /tmp "$PACKAGE_URL" && \
    apt-get -y update && \
    service postgresql start && \
    apt-get -yq install /tmp/$(basename "$PACKAGE_URL") && \
    service postgresql stop && \
    service supervisor stop && \
    rm -f /tmp/$(basename "$PACKAGE_URL") && \
    rm -rf /var/log/onlyoffice && \
    rm -rf /var/lib/apt/lists/*

VOLUME /var/log/onlyoffice /var/lib/onlyoffice /var/www/onlyoffice/Data /var/lib/postgresql /var/lib/rabbitmq /var/lib/redis /usr/share/fonts/truetype/custom

EXPOSE 80 443

COPY ./apps/onlyoffice-ds-ce/entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]

LABEL "maintainer"="TrueCharts <info@truecharts.org>"
LABEL "org.opencontainers.image.source"="https://github.com/truecharts/apps"
