#!/bin/sh
echo "== Current Directory =="
pwd

echo "== Files =="
ls -la

echo "== Starting App =="
./main --config /mounts/configs/glance.yml

