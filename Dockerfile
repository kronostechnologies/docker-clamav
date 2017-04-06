FROM alpine:edge
LABEL maintainer "sysadmin@kronostechnologies.com"

RUN apk add --update \
        bash \
        clamav \
        clamav-libunrar && \
    rm -fr /var/cache/apk/*

RUN mkdir /run/clamav && chown clamav:clamav /run/clamav && freshclam
COPY ./configuration/conf.d/clamd.conf /etc/clamd.conf


COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 3310
CMD ["/entrypoint.sh"]
