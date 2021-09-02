#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
# ==============================================================================
# Setup MQTT Explorer settings file
# ==============================================================================

# MQTT variables
declare host
declare port
declare username
declare password

# TODO: Support configuration for mqtts (https://github.com/merbanan/rtl_433/issues/1633)
if ! bashio::services.available "mqtt"; then
    bashio::exit.nok "No internal MQTT service found and no MQTT server defined. Please install Mosquitto broker."
else
    bashio::log.info "MQTT service found, fetching server detail ..."

    host=$(bashio::services "mqtt" "host")
    port=$(bashio::services "mqtt" "port")

    bashio::log.info "Configuring mqtt server '${host}:${port}'"

    username=$(bashio::services "mqtt" "username")
    password=$(bashio::services "mqtt" "password")

    bashio::log.info "Configuring mqtt user '${username}'"

fi

if [ ! -d /root/.config/MQTT-Explorer ]; then
    mkdir -p /root/.config/MQTT-Explorer
fi

bashio::var.json \
    host "${host}" \
    port "${port}" \
    username "${username}" \
    password "${password}" |
    tempio \
        -template /usr/share/tempio/settings.json.gtpl \
        -out /root/.config/MQTT-Explorer/settings.json
