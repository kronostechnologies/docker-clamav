FROM debian:bullseye-slim
LABEL maintainer "na-qc@equisoft.com"

ENV CLAMD_CONF="" \
    FRESHCLAM_CONF=""

RUN apt-get update && \
     apt-get install -y --no-install-recommends ca-certificates libclamav9 clamav-daemon clamav-freshclam && \
     apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Permission & clamd.conf setup
RUN mkdir /run/clamav && rm /var/log/clamav/freshclam.log && mkfifo /var/log/clamav/freshclam.log && chown -R clamav:clamav /run/clamav/ /var/lib/clamav/ /var/log/clamav/
COPY ./conf.d/clamd.conf /etc/clamav/clamd.conf
COPY ./conf.d/freshclam.conf /etc/clamav/freshclam.conf

# Install start/stop scripts
COPY ./entrypoint /k

# Install entrypoint
ADD https://github.com/kronostechnologies/docker-init-entrypoint/releases/download/1.2.0/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Update definitions
RUN freshclam --log=/dev/null

VOLUME /var/lib/clamav

EXPOSE 3310

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
