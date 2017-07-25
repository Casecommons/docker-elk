# https://github.com/elastic/kibana-docker
FROM docker.elastic.co/kibana/kibana:5.5.0
COPY config/ /usr/share/kibana/config/

# Add your kibana plugins setup here
# Example: RUN kibana-plugin install <name|url>

RUN kibana-plugin install https://github.com/sivasamyk/logtrail/releases/download/v0.1.18/logtrail-5.5.0-0.1.18.zip

# USER root
# RUN yum update -y
# RUN yum install -y nmap-ncat
#
# COPY entrypoint.sh /tmp/entrypoint.sh
# RUN chmod +x /tmp/entrypoint.sh
#
# USER kibana
#
# CMD ["/tmp/entrypoint.sh"]
