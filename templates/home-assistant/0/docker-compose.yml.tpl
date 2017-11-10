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
    # links:
    #   - appdaemon
#   appdaemon:
#     image: acockburn/appdaemon:latest
#     restart: unless-stopped
#     environment:
#       - HA_URL="http://hass:8123"
# {{- if ne .Values.APPD_HASS_KEY ""}}
#       - HA_KEY="${APPD_HASS_KEY}"
# {{- end}}
#       - DASH_URL="http://0.0.0.0:5050"
#     expose:
#       - "5050"
#     links:
#       - hass