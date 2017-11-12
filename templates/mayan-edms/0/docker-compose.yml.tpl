version: '2.1'

# volumes:
#     broker:
#         driver: local
#     app:
#         driver: local
#     db:
#         driver: local
#     results:
#         driver: local

services:
  broker:
    image: healthcheck/rabbitmq
    environment:
      RABBITMQ_DEFAULT_USER: mayan
      RABBITMQ_DEFAULT_PASS: mayan
      RABBITMQ_DEFAULT_VHOST: mayan
    volumes:
      - broker:/var/lib/rabbitmq
  results:
    container_name: mayan-edms-results
    image: healthcheck/redis
    volumes:
      - results:/data
{{- if eq .Values.MAYAN_DATABASE_DRIVER "postgres"}}
  db:
    container_name: mayan-edms-db
    image: healthcheck/postgres
    environment:
      POSTGRES_DB: mayan
      POSTGRES_PASSWORD: mayan-password
      POSTGRES_USER: mayan
    volumes:
      - db:/var/lib/postgresql/data
{{- end}}
  mayan-edms:
    container_name: mayan-edms-app
    image: mayanedms/mayanedms:2.6
    depends_on:
      broker:
        condition: service_healthy
      db:
        condition: service_healthy
      results:
        condition: service_healthy
    environment:
      MAYAN_BROKER_URL: amqp://mayan:mayan@broker:5672/mayan
      MAYAN_CELERY_RESULT_BACKEND: redis://results:6379/0
{{- if eq .Values.MAYAN_DATABASE_DRIVER "postgres"}}
      # MAYAN_DATABASE_DRIVER: django.db.backends.postgres
      # MAYAN_DATABASE_HOST: db
      # MAYAN_DATABASE_NAME: mayan
      # MAYAN_DATABASE_PASSWORD: mayan-password
      # MAYAN_DATABASE_USER: mayan
{{- end}}
    expose:
      - "80"
    volumes:
      - app:/var/lib/mayan
