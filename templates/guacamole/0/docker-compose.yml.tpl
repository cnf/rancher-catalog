version: '2'
services:
  guacd:
    image: guacamole/guacd:0.9.13-incubating
    restart: always
    expose: 
      - "4822"
    networks:
      - guacamole
    links:
      - guacamole

  guacamole:
    image: guacamole/guacamole:0.9.13-incubating
    restart: always
    environment:
      LDAP_HOSTNAME: ${LDAP_HOSTNAME}
      LDAP_PORT: ${LDAP_PORT}
      LDAP_ENCRYPTION_METHOD: ${LDAP_ENCRYPTION_METHOD}
      LDAP_USER_BASE_DN: ${LDAP_USER_BASE_DN}
      {{- if ne .Values.LDAP_SEARCH_BIND_DN ""}}
      LDAP_SEARCH_BIND_DN: ${LDAP_SEARCH_BIND_DN}
      {{- end}}
      {{- if ne .Values.LDAP_SEARCH_BIND_PASSWORD ""}}
      LDAP_SEARCH_BIND_PASSWORD: ${LDAP_SEARCH_BIND_PASSWORD}
      {{- end}}
      {{- if ne .Values.LDAP_CONFIG_BASE_DN ""}}
      LDAP_CONFIG_BASE_DN: ${LDAP_CONFIG_BASE_DN}
      {{- end}}
      {{- if ne .Values.LDAP_GROUP_BASE_DN ""}}
      LDAP_GROUP_BASE_DN: ${LDAP_GROUP_BASE_DN}
      {{- end}}
      {{- if ne .Values.LDAP_USERNAME_ATTRIBUTE ""}}
      LDAP_USERNAME_ATTRIBUTE: ${LDAP_USERNAME_ATTRIBUTE}
      {{- end}}
      # GUACD_PORT_4822_TCP_ADDR: guacd
      # GUACD_PORT_4822_TCP_PORT: 4822
    expose: 
      - "8080"
    networks:
      - guacamole
    links:
      - "guacd:guacd"
    depends_on:
      - guacd