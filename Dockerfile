FROM debian:buster-slim
LABEL maintainer "sysadmin@kronostechnologies.com"

ENV CLAMD_CONF="" \
    FRESHCLAM_CONF=""

RUN echo 'Package: *\nPin: release a=unstable\nPin-Priority: 100' > /etc/apt/preferences.d/sid ; \
    echo "deb http://deb.debian.org/debian/ sid main contrib non-free" > /etc/apt/sources.list.d/sid.list

RUN cat /etc/apt/preferences.d/sid
RUN apt-get update && \
     apt-get install -y --no-install-recommends -t sid clamav-daemon clamav-freshclam && \
     apt-get install -y --no-install-recommends ca-certificates && \
     apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

RUN mkdir /run/clamav && rm /var/log/clamav/freshclam.log && mkfifo /var/log/clamav/freshclam.log && chown -R clamav:clamav /run/clamav/ /var/lib/clamav/ /var/log/clamav/

COPY ./conf.d/clamd.conf /etc/clamav/clamd.conf
COPY ./conf.d/freshclam.conf /etc/clamav/freshclam.conf
RUN freshclam --log=/dev/null

# Install start/stop scripts
COPY ./entrypoint /k

# Install entrypoint
ADD https://github.com/kronostechnologies/docker-init-entrypoint/releases/download/1.2.0/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

VOLUME /var/lib/clamav

EXPOSE 3310

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
