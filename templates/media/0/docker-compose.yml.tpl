version: '2'
services:
{{- if .Values.SONARR_ENABLE }}
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

{{- if .Values.PLEXPY_ENABLE }}
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

{{- if .Values.QBITTORRENT_ENABLE }}
  qbittorrent:
    image: linuxserver/qbittorrent:latest
    volumes:
      - ${QBITTORRENT_CONFIG}:/config
      - ${DOWNLOADS}:/downloads
      expose:
      - "8080/tcp"
      - "${TORRENT_PORT}/tcp"
      - "${TORRENT_PORT}/udp"
      ports:
      - "${TORRENT_PORT}:${TORRENT_PORT}/tcp"
      - "${TORRENT_PORT}:${TORRENT_PORT}/udp"
{{- if ne .Values.QBITTORRENT_PORT ""}}
      - "${QBITTORRENT_PORT}:8080/tcp"
{{- end}}
    environment:
      TZ: ${TIMEZONE}
{{- end}}