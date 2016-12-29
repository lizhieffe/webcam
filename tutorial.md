Software Install
1. v42l-ctl
sudo apt-get install v4l-util

List all video devices picked up by the kernel
v4l2-ctl --list-devices

List the video output format for the device:
v4l2-ctl --list-formats

Set camera pixel-format to H264
v4l2-ctl --device=/dev/video0 --set-fmt-video=width=800,height=600,pixelformat=1

Test H264 playback with vlc
cvlc v4l2:///dev/video0 --demux h264

Playback works. we get a H264 stream from the cam. now let's stream it over the
network via HTTP:
cvlc v4l2:///dev/video1:chroma=h264:width=800:height=600 --sout '#standard{access=http,mux=ts,dst=localhost:8080,name=stream,mime=video/ts}' -vvv

Play from the HTTP stream:
mplayer http://localhost:8080


Ref:
https://wiki.matthiasbock.net/index.php/Logitech_C920,_streaming_H.264
https://wiki.videolan.org/Documentation:Streaming_HowTo/Command_Line_Examples/
