#!/bin/sh
echo "== Current Directory =="
pwd

echo "== Files =="
ls -la

echo "== Starting App =="
/layers/google.go.build/bin/main --config /mounts/configs/glance.yml
