#!/bin/bash

/opt/prometheus/prometheus \
  --config.file=/opt/prometheus/prometheus.yml \
  --storage.tsdb.path=/tmp/prometheus &

/opt/alertmanager/alertmanager \
  --config.file=/opt/alertmanager/alertmanager.yml &

/usr/sbin/grafana-server \
  --homepath=/usr/share/grafana \
  --config=/etc/grafana/grafana.ini \
  --http.port=80 &


nginx -g "daemon off;"
