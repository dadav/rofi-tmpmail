#!/bin/bash

# Select an action
if [[ $# -eq 0 ]]; then
  action="$(echo -e 'copy\ngenerate\nlist\nrecent' | rofi -show drun -dmenu -p 'action')"
  exec "$0" "$action"
fi

function notify() {
  if command -v notify-send >/dev/null 2>&1; then
    notify-send -u normal "$1"
  fi
}

function term() {
  t="xterm"
  for t in kitty urxvt termine xterm; do
    if command -v $t >/dev/null 2>&1; then
      exec $t -e $*
    fi
  done

  notify "Terminal not supported"
}

action="$1"
case "$action" in
  copy)
    mail="$(tmpmail | awk 'NR==1{ print $4 }')"
    echo -n "$mail" | xclip -i
    notify "Copied $mail to clipboard"
    ;;
  generate)
    mail="$(tmpmail -g)"
    echo -n "$mail" | xclip -i
    notify "Copied $mail to clipboard"
    ;;
  list)
    mails="$(tmpmail | grep '^[0-9]')"
    mail_to_show="$(echo "$mails" | rofi -dmenu -p 'open' | awk '{print $1}')"
    term tmpmail "$mail_to_show"
    ;;
  recent)
    term tmpmail -r
    ;;
esac
