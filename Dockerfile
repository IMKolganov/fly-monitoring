FROM ubuntu:22.04

# Install packages
RUN apt-get update && \
    apt-get install -y wget curl supervisor nginx && \
    useradd -m monitoring

# Prometheus
RUN wget https://github.com/prometheus/prometheus/releases/download/v2.52.0/prometheus-2.52.0.linux-amd64.tar.gz && \
    tar xvf prometheus-2.52.0.linux-amd64.tar.gz && \
    mv prometheus-2.52.0.linux-amd64 /opt/prometheus

# Alertmanager
RUN wget https://github.com/prometheus/alertmanager/releases/download/v0.27.0/alertmanager-0.27.0.linux-amd64.tar.gz && \
    tar xvf alertmanager-0.27.0.linux-amd64.tar.gz && \
    mv alertmanager-0.27.0.linux-amd64 /opt/alertmanager

# Grafana
RUN wget https://dl.grafana.com/oss/release/grafana_10.4.2_amd64.deb && \
    apt install -y ./grafana_10.4.2_amd64.deb

# Copy configs
COPY prometheus.yml /opt/prometheus/prometheus.yml
COPY alertmanager.yml /opt/alertmanager/alertmanager.yml
COPY nginx.conf /etc/nginx/sites-available/default
COPY run.sh /run.sh

RUN chmod +x /run.sh

EXPOSE 80

CMD ["/run.sh"]
