#!/bin/bash

# Script to play HTTP streaming

INTERNAL_IP=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')
PORT=8080

#mplayer http://${INTERNAL_IP}:${PORT}
cvlc http://${INTERNAL_IP}:${PORT}
