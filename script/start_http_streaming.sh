#!/bin/bash

# Script to start HTTP streaming

INTERNAL_IP=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')
PORT=8080

VIDEO_CODEC=h264
CONTAINER=ts

WIDTH=800
HEIGHT=300

Start() {
  echo "Starting vlc HTTP streaming ..."
  SOUT='#transcode{acodec=a52,ab=32}:http{mux='${CONTAINER}',dst='${INTERNAL_IP}':'${PORT}',name=stream,mime=video/ts}'
  cvlc v4l2:///dev/video0:chroma=${VIDEO_CODEC}:width=${WIDTH}:height=${HEIGHT} :input-slave="alsa://hw:1,0" --sout ${SOUT} -vvv
}

StartVideoOnly() {
  echo "Starting vlc HTTP streaming (video only) ..."
  SOUT='#standard{access=http,mux='${CONTAINER}',dst='${INTERNAL_IP}':'${PORT}',name=stream,mime=video/ts}'
  cvlc v4l2:///dev/video0:chroma=${VIDEO_CODEC}:width=${WIDTH}:height=${HEIGHT} --sout $SOUT -vvv
}

# TODO: add audio in output.
SaveToDisk() {
  echo "Saving vlc HTTP streaming to disk ..."
  SOUT='#standard{access=file,mux='${CONTAINER}',dst=output.ts}'
  cvlc v4l2:///dev/video0:chroma=${VIDEO_CODEC}:width=${WIDTH}:height=${HEIGHT} --sout $SOUT -vvv
}

case "$1" in
  start)
    Start
    ;;
  start_video_only)
    StartVideoOnly
    ;;
  save_to_disk)
    SaveToDisk
    ;;
  *)
    echo "Usage: $0 {start|start_video_only|save_to_disk|stop}"
    ;;
esac

exit 0
