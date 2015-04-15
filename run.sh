#!/bin/sh

set -e

LOGSENE_TOKEN=${TOKEN}
KIBANA_INDEX=${TOKEN}_kibana 
KIBANA_ES_URL="https://logsene-receiver.sematext.com:443"

curl -XPOST ${KIBANA_ES_URL}/${KIBANA_INDEX}

KIBANA_USER=${USER:-logsene}
KIBANA_PASSWORD=${PASSWORD:-secret}
CERT_SUBJ=${CERT:-"/C=GB/ST=London/L=London/O=GlobalSecurity/OU=IT/CN=kibana.example.com"}
# generate user and password for Kibana4
htpasswd -cb /opt/kibana-${KIBANA_VERSION}/src/.htpasswd $KIBANA_USER $KIBANA_PASSWORD 
# generate SSL certificate 
mkdir /ssl
openssl req -nodes -newkey rsa:2048 -keyout /ssl/server.key -out /ssl/server.csr -subj ${CERT_SUBJ} 
openssl x509 -req -days 365 -in /ssl/server.csr -signkey /ssl/server.key -out /ssl/server.crt
sed -i "s;^elasticsearch_url:.*;elasticsearch_url: \"${KIBANA_ES_URL}\";" "/opt/kibana-${KIBANA_VERSION}/config/kibana.yml"
sed -i "s;^kibana_index:.*;kibana_index: \"${KIBANA_INDEX}\";" "/opt/kibana-${KIBANA_VERSION}/config/kibana.yml"
sed -i "s;^#.*ssl_cert_file:.*;ssl_cert_file: \"/ssl/server.crt\";" "/opt/kibana-${KIBANA_VERSION}/config/kibana.yml"
sed -i "s;^#.*ssl_key_file:.*;ssl_key_file: \"/ssl/server.key\";" "/opt/kibana-${KIBANA_VERSION}/config/kibana.yml"

# mesos-friendly change
unset HOST
unset PORT

exec /opt/kibana-${KIBANA_VERSION}/bin/kibana
