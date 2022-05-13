FROM docker:20.10.16-dind@sha256:6add3a812cacaf78c5914697b64e53426bce6e60c3e83629d9530b6c833b32fa

# hadolint ignore=DL3008,DL3019,DL3018,DL3015,SC2086,SC2155
RUN apk update && apk add nano docker-compose curl bash

LABEL "org.opencontainers.image.source"="https://github.com/truecharts/containers"
