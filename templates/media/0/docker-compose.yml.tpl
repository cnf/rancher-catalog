version: '2'
services:
SONARR_ENABLE
{{- if eq .Values.SONARR_ENABLE true}}
  sonarr:
    image: linuxserver/sonarr:latest
    volumes:
      - ${SONARR_CONFIG}:/config
      - ${SONARR_TV}:/tv
      - ${DOWNLOADS}:/downloads
    expose:
      - "8989/tcp"
{{- if ne .Values.SONARR_PORT ""}}
    ports:
      - "${SONARR_PORT}:8989/tcp"
{{- end}}
    environment:
      TZ: ${TIMEZONE}
{{- end}}

{{- if eq .Values.PLEXPY_ENABLE true}}
  plexpy:
    image: linuxserver/plexpy:latest
    volumes:
      - ${PLEXPY_CONFIG}:/config
    expose:
      - "8181/tcp"
{{- if ne .Values.SONARR_PORT ""}}
    ports:
      - "${PLEXPY_PORT}:8181/tcp"
{{- end}}
    environment:
      TZ: ${TIMEZONE}
{{- end}}

#  qbittorrent:
#    image: