---
version: '2'
services:
  hass:
    image: homeassistant/home-assistant:latest
    volumes:
      - ${HASS_CONFIG}:/config
    devices:
      - "/dev/bus/usb:/dev/bus/usb"
    expose:
      - "8123"
    restart: unless-stopped
  appdaemon:
    image: acockburn/appdaemon:latest
    environment:
      - HA_URL="http://hass:8123"
{{- if ne .Values.APPD_HASS_KEY ""}}
      - HA_KEY="${APPD_HASS_KEY}"
{{- end}}
    links:
      - hass