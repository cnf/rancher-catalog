version: '2'
services:
  influxdb:
    image: influxdb:${INFLUXDB_VERSION}
    container_name: influxdb
    restart: always
    volumes:
      - ${INFLUXDB_DATA}:/var/lib/influxdb
{{- if eq .Values.INFLUXDB_EXPOSE "true"}}
    ports:
      - "${INFLUXDB_PORT}:8086/tcp"
{{- else}}
    expose:
      - "8086/tcp"
{{- end}}
