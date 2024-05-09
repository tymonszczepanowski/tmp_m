#!/bin/env bash

if command -v docker &> /dev/null; then
  echo "[image] Removing ns3 image."
  sudo docker rmi -f ns3
else
  echo "[image] Docker not found."
  exit 1
fi
