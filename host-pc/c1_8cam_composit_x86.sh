#!/bin/bash

WIDTH=${1:-1920}
HEIGHT=${2:-1080}

echo WHOLE SIZE: $WIDTH X $HEIGHT

S_WIDTH=$(( WIDTH / 3 ))
S_HEIGHT=$(( HEIGHT / 3 ))

echo SINGLE SIZE: $S_WIDTH X $S_HEIGHT

gst-launch-1.0 \
  compositor name=comp \
  sink_0::xpos=$(( S_WIDTH * 0 ))  sink_0::ypos=$(( S_HEIGHT * 0 ))  sink_0::width=$S_WIDTH sink_0::height=$S_HEIGHT \
  sink_1::xpos=$(( S_WIDTH * 1 ))  sink_1::ypos=$(( S_HEIGHT * 0 ))  sink_1::width=$S_WIDTH sink_1::height=$S_HEIGHT \
  sink_2::xpos=$(( S_WIDTH * 2 ))  sink_2::ypos=$(( S_HEIGHT * 0 ))  sink_2::width=$S_WIDTH sink_2::height=$S_HEIGHT \
  sink_3::xpos=$(( S_WIDTH * 0 ))  sink_3::ypos=$(( S_HEIGHT * 1 ))  sink_3::width=$S_WIDTH sink_3::height=$S_HEIGHT \
  sink_4::xpos=$(( S_WIDTH * 1 ))  sink_4::ypos=$(( S_HEIGHT * 1 ))  sink_4::width=$S_WIDTH sink_4::height=$S_HEIGHT \
  sink_5::xpos=$(( S_WIDTH * 2 ))  sink_5::ypos=$(( S_HEIGHT * 1 ))  sink_5::width=$S_WIDTH sink_5::height=$S_HEIGHT \
  sink_6::xpos=$(( S_WIDTH * 0 ))  sink_6::ypos=$(( S_HEIGHT * 2 ))  sink_6::width=$S_WIDTH sink_6::height=$S_HEIGHT \
  sink_7::xpos=$(( S_WIDTH * 1 ))  sink_7::ypos=$(( S_HEIGHT * 2 ))  sink_7::width=$S_WIDTH sink_7::height=$S_HEIGHT \
  ! videoconvert ! "video/x-raw,width=${WIDTH},height=${HEIGHT}" \
  ! queue \
  ! xvimagesink \
  udpsrc caps='application/x-rtp, sampling=YCbCr-4:2:2, depth=(string)8, width=(string)1920, height=(string)1280' port=5004 ! rtpvrawdepay ! textoverlay text="Cam1" ! videoconvert ! 'video/x-raw' ! comp.sink_0 \
  udpsrc caps='application/x-rtp, sampling=YCbCr-4:2:2, depth=(string)8, width=(string)1920, height=(string)1280' port=5005 ! rtpvrawdepay ! textoverlay text="Cam2" ! videoconvert ! 'video/x-raw' ! comp.sink_1 \
  udpsrc caps='application/x-rtp, sampling=YCbCr-4:2:2, depth=(string)8, width=(string)1920, height=(string)1280' port=5006 ! rtpvrawdepay ! textoverlay text="Cam3" ! videoconvert ! 'video/x-raw' ! comp.sink_2 \
  udpsrc caps='application/x-rtp, sampling=YCbCr-4:2:2, depth=(string)8, width=(string)1920, height=(string)1280' port=5007 ! rtpvrawdepay ! textoverlay text="Cam4" ! videoconvert ! 'video/x-raw' ! comp.sink_3 \
  udpsrc caps='application/x-rtp, sampling=YCbCr-4:2:2, depth=(string)8, width=(string)1920, height=(string)1280' port=5008 ! rtpvrawdepay ! textoverlay text="Cam5" ! videoconvert ! 'video/x-raw' ! comp.sink_4 \
  udpsrc caps='application/x-rtp, sampling=YCbCr-4:2:2, depth=(string)8, width=(string)1920, height=(string)1280' port=5009 ! rtpvrawdepay ! textoverlay text="Cam6" ! videoconvert ! 'video/x-raw' ! comp.sink_5 \
  udpsrc caps='application/x-rtp, sampling=YCbCr-4:2:2, depth=(string)8, width=(string)1920, height=(string)1280' port=5010 ! rtpvrawdepay ! textoverlay text="Cam7" ! videoconvert ! 'video/x-raw' ! comp.sink_6 \
  udpsrc caps='application/x-rtp, sampling=YCbCr-4:2:2, depth=(string)8, width=(string)1920, height=(string)1280' port=5011 ! rtpvrawdepay ! textoverlay text="Cam8" ! videoconvert ! 'video/x-raw' ! comp.sink_7 \
