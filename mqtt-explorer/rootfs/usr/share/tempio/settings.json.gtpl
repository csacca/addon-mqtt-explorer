{
  "ConnectionManager_connections": {
    "Home Assistant": {
      "configVersion": 1,
      "certValidation": true,
      "clientId": "mqtt-explorer-23a9be8a",
      "id": "{{ .host }}",
      "name": "Home Assistant",
      "encryption": false,
      "password": "{{ .password }}",
      "username": "{{ .username }}",
      "subscriptions": [
        {
          "topic": "#",
          "qos": 0
        },
        {
          "topic": "$SYS/#",
          "qos": 0
        }
      ],
      "type": "mqtt",
      "host": "{{ .host }}",
      "port": {{ .port }},
      "protocol": "mqtt"
    }
  },
  "Settings": {
    "timeLocale": "en-US",
    "topicOrder": "none",
    "highlightTopicUpdates": true,
    "valueRendererDisplayMode": "diff",
    "selectTopicWithMouseOver": false,
    "theme": "dark"
  }
}