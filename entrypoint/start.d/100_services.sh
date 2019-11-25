#!/bin/bash

ionice -c 3 nice -n 19 freshclam -d &&
ionice -c 3 nice -n 19 clamd &
