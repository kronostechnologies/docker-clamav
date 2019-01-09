#!/bin/bash

if [[ -n "$CLAMD_CONF" ]]; then
  echo "Using environment variable 'CLAMD_CONF' as content for '/etc/clamav/clamd.conf'"
  echo -n "$CLAMD_CONF" > /etc/clamav/clamd.conf
fi

if [[ -n "$FRESHCLAM_CONF" ]]; then
  echo "Using environment variable 'FRESHCLAM_CONF' as content for '/etc/clamav/freshclam.conf'"
  echo -n "$FRESHCLAM_CONF" > /etc/clamav/freshclam.conf
fi
