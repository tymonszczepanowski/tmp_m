#!/bin/env bash

if command -v docker &> /dev/null; then
  echo "[image] Building ns3 image."
  sudo docker build -f ns-o-ran.dockerfile -t ns3 .
else
  echo "[image] Docker not found."
  exit 1
fi
