#!/usr/bin/env bash

MNT=/data/media/0/
if [ ! -h "/home/nemo/Pictures/Android" ]; then
  if [ -d $MNT/Pictures ]; then
    ln -s $MNT/DCIM /home/nemo/Pictures/Camera/Android
    ln -s $MNT/Download /home/nemo/Downloads/Android
    ln -s $MNT/Movies /home/nemo/Videos/Android
    ln -s $MNT/Music /home/nemo/Music/Android
    ln -s $MNT/Pictures /home/nemo/Pictures/Android
    ln -s $MNT/Playlists /home/nemo/Playlists/Android
    ln -s $MNT/Podcasts /home/nemo/Music/AndroidPodcasts
  fi
fi
