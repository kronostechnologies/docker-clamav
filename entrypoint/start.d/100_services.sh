#!/bin/bash

ionice -c3 nice -n19 freshclam -d &&
ionice -c3 nice -n19 clamd &
