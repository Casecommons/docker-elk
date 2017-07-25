# https://github.com/elastic/logstash-docker
FROM docker.elastic.co/logstash/logstash:5.5.0
COPY config/logstash.yml /usr/share/logstash/config/logstash.yml
COPY pipeline/ /usr/share/logstash/pipeline/

# Add your logstash plugins setup here
# Example: RUN logstash-plugin install logstash-filter-json

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
