#!/bin/bash

# Script to start HTTP streaming

INTERNAL_IP=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')
PORT=8080

SOUT='#standard{access=http,mux=ts,dst='${INTERNAL_IP}':'${PORT}',name=stream,mime=video/ts}'

# -vvv: extra verbose
cvlc v4l2:///dev/video0:chroma=h264:width=800:height=600 --sout $SOUT -vvv
