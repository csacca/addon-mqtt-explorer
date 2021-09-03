ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base-debian:bullseye
# hadolint ignore=DL3006
FROM ${BUILD_FROM} as builder

ENV LANG C.UTF-8

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /app

# hadolint ignore=DL3008
RUN \
    set -x \
    && apt-get update \
    && curl -fsSL https://deb.nodesource.com/setup_14.x | bash - \
    && apt-get install -y --no-install-recommends \
        nodejs \
    \
    && curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | \
        gpg --dearmor | \
        tee /usr/share/keyrings/yarnkey.gpg >/dev/null \
    && echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | \
        tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        yarn \
    \
    && apt-get install -y --no-install-recommends \
        git \
        build-essential \
        libglib2.0-0 \
        libx11-6 \
        libx11-xcb1 \
        libxcomposite1 \
        libxcursor1 \
        libxdamage1 \
        libxext6 \
        libxi6 \
        libxtst6 \
        libnss3 \
        libdbus-1-3 \
        libgdk-pixbuf2.0-0 \
        libgtk-3-0 \
        libxss1 \
        libasound2 \
    \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# hadolint ignore=DL3008
RUN \
    set -x \
    && git clone https://github.com/thomasnordquist/MQTT-Explorer.git /app \
    && git checkout tags/0.0.0-0.4.0-beta1 \
    && yarn \
    && yarn prepare-release

COPY builder_rootfs /

RUN \
    set -x \
    && yarn run \
        electron-builder \
            --linux deb \
            --config /app/config.yaml \
            --publish never \
            --projectDir ./build/clean

#
# Main container
#

# hadolint ignore=DL3006
FROM $BUILD_FROM

ENV LANG C.UTF-8

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

COPY --from=builder /app/build/clean/build/MQTT-Explorer_0.4.0-beta1_*.deb /

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
    \
    && dpkg -i MQTT-Explorer_0.4.0-beta1_*.deb \
    && apt-get install -y --no-install-recommends \
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
