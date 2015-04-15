# Kibana 4 for Logsene in docker

This is dockerized version of [kibana 4](https://github.com/elasticsearch/kibana)
in a small container image preconfigured to be used with [Logsene](http://www.sematext.com/logsene/)

Parameters:
- TOKEN - Your Logsene App-Token (mandatory parameter)
- KIBANA_USER - user to create in .htpasswd for Kibana4, defaults to "kibana"
- KIBANA_PASSWORD - password to use in .htpasswd, defaults to "secret"
- CERT - optional, openssl '-subj' parameter to generate the SSL certificate defaults to "/C=GB/ST=London/L=London/O=GlobalSecurity/OU=IT/CN=example.com"

## Running

```
docker pull sematext/kibana4
docker run -d -p 5609:5601 -e TOKEN=YOUR-APP-TOKEN -e USER=logsene -e PASSWORD=secret sematext/kibana4
```

## Access
Open the web browser https://user:password@hostname:port/ in our example

```
https://logsene:secret@localhost:5609/
```

## Contributions
This work is derived from bobrik/docker-kibana4 with following modifications:
- using Logsene instead of Elasticsearch
- authentication for Kibana4 
- generate self signed SSL certificate



