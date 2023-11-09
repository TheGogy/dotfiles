#!/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

function get_volume {
	pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\d+(?=%)' | head -n 1
}

function is_mute {
	pactl get-sink-mute @DEFAULT_SINK@ | cut -c7-
}

function send_notification {
	volume=`get_volume`
	# bar=$(seq -s "█" $(($volume/5)) | sed 's/[0-9]//g')
	local bar=$(printf '█%.0s' $(seq 1 $(($volume/5))))
	if [ `is_mute` = "yes" ]
	then
		volume="--"
	fi

	lastid=$(<~/.config/hypr/scripts/volume-last-id)
	echo "$(notify-send "Volume" "$bar [$volume]" -r $lastid -p)" > ~/.config/hypr/scripts/volume-last-id
}

case $1 in
	up)
		pactl set-sink-volume @DEFAULT_SINK@ +2%
		send_notification
		;;
	down)
		pactl set-sink-volume @DEFAULT_SINK@ -2%
		send_notification
		;;
	mute-toggle)
		pactl set-sink-mute @DEFAULT_SINK@ toggle
		send_notification
		;;
esac
