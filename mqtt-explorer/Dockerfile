ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base-debian:bullseye
# hadolint ignore=DL3006
FROM $BUILD_FROM

ENV LANG C.UTF-8

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008
RUN \
    set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        libnss3 \
        libxcomposite1 \
        libxtst6 \
        libdbus-1-3 \
        libgtk-3-0 \
        libatk1.0-0 \
        libxss1 \
        libasound2 \
        libatk-bridge2.0-0 \
        libatspi2.0-0 \
        libcups2 \
        tigervnc-common \
        tigervnc-standalone-server \
        openbox \
        xfonts-base \
        xfonts-scalable \
        novnc \
        wmctrl \
        nginx \
    \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
COPY MQTT-Explorer_0.4.0-beta1_*.deb /tmp/

ARG BUILD_ARCH
RUN \
    set -x \
    && if [ "${BUILD_ARCH}" = "aarch64" ]; then \
            export DEB_ARCH="arm64"; \
       elif [ "${BUILD_ARCH}" = "amd64" ]; then \
            export DEB_ARCH="amd64"; \
       elif [ "${BUILD_ARCH}" = "armv7" ]; then \
            export DEB_ARCH="armv7l"; \
       else \
            echo "Unsupported BUILD_ARCH ${BUILD_ARCH}."; \
            exit 1; \
       fi \
    && dpkg -i /tmp/MQTT-Explorer_0.4.0-beta1_${DEB_ARCH}.deb \
    && rm /tmp/MQTT-Explorer_0.4.0-beta1_*.deb

COPY rootfs /

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Christopher Sacca <csacca@csacca.net>" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant Community Add-ons" \
    org.opencontainers.image.authors="Christopher Sacca <csacca@csacca.net>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
