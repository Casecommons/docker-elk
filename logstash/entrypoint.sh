#!/usr/bin/env bash

# Wait for the Elasticsearch container to be ready before starting Kibana.
echo "Stalling for Elasticsearch"

sleep 30

echo "Starting Logstash"
exec /usr/local/bin/docker-entrypoint
