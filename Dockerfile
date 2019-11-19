FROM debian:buster-slim
LABEL maintainer "sysadmin@kronostechnologies.com"

ENV CLAMD_CONF="" \
    FRESHCLAM_CONF=""

RUN apt-get update && apt-get install -y --no-install-recommends \
        clamav-daemon \
        clamav-freshclam && \
        apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Permission & clamd.conf setup
RUN mkdir /run/clamav && chown clamav:clamav /run/clamav && chown -R clamav:clamav /var/lib/clamav/
COPY ./conf.d/clamd.conf /etc/clamav/clamd.conf
COPY ./conf.d/freshclam.conf /etc/clamav/freshclam.conf

# Install start/stop scripts
COPY ./entrypoint /k

# Install entrypoint
ADD https://github.com/kronostechnologies/docker-init-entrypoint/releases/download/1.2.0/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Update definitions
RUN freshclam

VOLUME /var/lib/clamav

EXPOSE 3310

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
