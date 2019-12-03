#!/usr/bin/env python3

from pymemcache.client.base import Client
#import os
import time
import random


def renewLock():
  lock, cas = client.gets('lock')

  if (lock is not None) and (lock != uid):
    return False

  if cas is None:
    return client.add('lock', uid, ttl, False)

  state = client.cas('lock', uid, cas, ttl, False)

  if state is None:
    return client.add('lock', uid, ttl, False)

  return state

ttl = 30
host = '127.0.0.1'
port = 11211

client = Client((host, port))
uid = str(random.randrange(12345678)).encode()

while True:
  if renewLock():
    print('Working')
    time.sleep(15)
  else:
    print('Waiting my turn')
    time.sleep(1)
