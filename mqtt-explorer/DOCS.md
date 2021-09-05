# Home Assistant Custom Add-on: MQTT Explorer

A Home Assistant addon to run MQTT Explorer.

## About

MQTT Explorer is a comprehensive MQTT client that provides a structured
overview of your MQTT topics and makes working with devices/services on
your broker dead-simple. Please support the developer of this software
at [MQTT Explorer][mqtt-explorer].

This addon provides an ingress environment for running MQTT Explorer.

## Installation

1. Use the following URL to add this repository:

```txt
https://github.com/csacca/hassio-addons
```

1. Search the Supervisor Add-on store for `MQTT Explorer`.

1. Start the `MQTT Explorer` add-on.

1. Click the `OPEN WEB UI` button

**Note**: This add-on requires a configured MQTT Broker in Home Assistant
(it auto configures MQTT Explorer)

## Configuration

**Note**: _Remember to restart the add-on when the configuration is changed._

Example add-on configuration:

```yaml
log_level: info
```

### Option: `log_level`

The `log_level` option controls the level of log output by the addon and can
be changed to be more or less verbose, which might be useful when you are
dealing with an unknown issue. Possible values are:

- `trace`: Show every detail, like all called internal functions.
- `debug`: Shows detailed debug information.
- `info`: Normal (usually) interesting events.
- `warning`: Exceptional occurrences that are not errors.
- `error`: Runtime errors that do not require immediate action.
- `fatal`: Something went terribly wrong. Add-on becomes unusable.

Please note that each level automatically includes log messages from a
more severe level, e.g., `debug` also shows `info` messages. By default,
the `log_level` is set to `info`, which is the recommended setting unless
you are troubleshooting.

## Authors & contributors

The author of [MQTT Explorer][mqtt-explorer] is [Thomas Nordquist][thomasnordquist]

The original setup of this repository is by [Christopher Sacca][csacca].

For a full list of all authors and contributors,
check [the contributor's page][contributors].

[contributors]: https://github.com/csacca/addon-mqtt-explorer/graphs/contributors
[csacca]: https://github.com/frenck
[mqtt-explorer]: http://mqtt-explorer.com/
[thomasnordquist]: https://github.com/thomasnordquist
