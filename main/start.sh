#! /bin/bash

# Uncomment to debug
set -eux

export GDAL_DRIVER_PATH=/usr/local/lib/gdalplugins/1.11
export PATH=$PATH:/home/mesa/meteosatlib-1.3/examples

PRODUCTS="${PRODUCTS:-EnhancedIr}"
FORMAT="${FORMAT:-JPEG}"
TIMESTR=$(/main/get_timestr.py)

temp_dir=/tmp/out/26312
mkdir $temp_dir || {
  echo "Can't create working directory $temp_dir" >&2
  exit 1
}
trap "rm -rf $temp_dir" EXIT SIGHUP SIGINT SIGTERM

cd /tmp/out

msat --Area=10,-50,60,10 --conv GTiff /tmp/in/abc

