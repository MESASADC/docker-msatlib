#! /usr/bin/env python
#
# Get the latest 15-min time
#
import sys
from datetime import datetime, timedelta

# Complete XRIT raw files for a given timestamp are only availably after this
LATENCY_MIN=9

if len(sys.argv) == 2:
    now = datetime.strptime(sys.argv[1], '%Y%m%d%H%M')
else:
    now = datetime.utcnow()
nearest = (now.minute / 15) * 15
if (now.minute - nearest) < LATENCY_MIN:
    now -= timedelta(minutes=15)
    nearest = (now.minute / 15) * 15
print now.replace(minute=nearest).strftime('%Y%m%d%H%M')
