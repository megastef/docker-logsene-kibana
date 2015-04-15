## Kibana 4 to analyze logs stored in Logsene

[About Logsene](http://www.sematext.com/logsene): *Centralized Logging, Log Management & Analytics has never been easier. Logsene is your ELK Stack in the Cloud or On Premises.*

This container supports SSL and authentication for Kibana4.

```
docker pull sematext/kibana4
docker run -d -p 5601:5601 -e TOKEN=YOUR-APP-TOKEN -e PASSWORD=secret sematext/kibana4
```
## Access
Open the web browser https://user:password@hostname:port/ in our example

```
https://kibana:secret@localhost:5609/
```

When Kibana 4 starts the first time it asks for an "index pattern" - you need to use the Logsene App Token here:
```
 [YOUR-APP-TOKEN_]YYYY-MM-DD 
```

When you need to run Kibana 4 for multiple Logsene Apps simply start the docker container on different ports e.g. “-p 5602:5601”.

## List of all parameters:
The following parameters can be used with "-e" command line option of docker. 

- TOKEN - Your Logsene App-Token (mandatory parameter)
- USER - user to create in .htpasswd for Kibana4, defaults to "kibana"
- PASSWORD - password to use in .htpasswd, defaults to "secret"
- CERT - optional, openssl '-subj' parameter to generate the SSL certificate defaults to "/C=GB/ST=London/L=London/O=GlobalSecurity/OU=IT/CN=example.com"

## Contributions
This work is derived from bobrik/docker-kibana4 with following modifications:
- using Logsene instead of Elasticsearch
- authentication for Kibana4 
- generate self signed SSL certificate



