---
version: '2'
services:
  hass:
    image: homeassistant/home-assistant:latest
    restart: unless-stopped
    volumes:
      - ${HASS_CONFIG}:/config
    expose:
      - "8123"
{{- if .Values.ENABLE_AIRSONOS}}
  airsonos:
    image: justintime/airsonos:latest
    restart: unless-stopped
    network_mode: host 
{{- end}}
{{- if .Values.ENABLE_HOMEBRIDGE}}
  homebridge:
    image: oznu/homebridge:latest
    restart: unless-stopped
    network_mode: host
    name: homebridge
    environment:
      - PUID: 1000
      - PGID: 1000
    volumes:
      - ${HOMEBRIDGE_CONFIG}:/homebridge
{{- end}}