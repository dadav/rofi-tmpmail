#!/bin/bash

# Select an action
if [[ $# -eq 0 ]]; then
  action="$(echo -e 'generate\nlist\nrecent' | rofi -dmenu -p 'action')"
  exec "$0" "$action"
fi

action="$1"

case "$action" in
  generate)
    echo "generate"
    ;;
  list)
    echo "list"
    ;;
  recent)
    echo "recent"
    ;;
esac
