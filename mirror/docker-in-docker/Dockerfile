FROM docker:20.10.15-dind@sha256:fb9cc626282893e4c7af33821af0ea7f6f8349d06955fef47efed35d6dbfc518

# hadolint ignore=DL3008,DL3019,DL3018,DL3015,SC2086,SC2155
RUN apk update && apk add nano docker-compose curl bash

LABEL "org.opencontainers.image.source"="https://github.com/truecharts/containers"
