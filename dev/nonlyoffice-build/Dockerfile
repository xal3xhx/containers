FROM ubuntu:14.04@sha256:60840958b25b5947b11d7a274274dc48ab32a2f5d18527f5dae2962b64269a3a
ARG VARIANT="2"

ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get -y update && \
    apt-get -y install python \
                       python3 \
                       sudo
RUN rm /usr/bin/python && ln -s /usr/bin/python2 /usr/bin/python
ADD . /build_tools
WORKDIR /build_tools

CMD cd tools/linux && \
    python3 ./automate.py

LABEL "maintainer"="TrueCharts <info@truecharts.org>"
LABEL "org.opencontainers.image.source"="https://github.com/truecharts/apps"
