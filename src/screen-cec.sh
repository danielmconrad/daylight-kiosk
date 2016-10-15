#!/bin/sh
CMD="$1"
export DISPLAY=:0

main () {
  echo "Date: $(date)"

  if [ "$CMD" = "on" ]
  then
    on
  elif [ "$CMD" = "off" ]
  then
    off
  else
    echo "[SCREEN] Usage: $0 <on|off>"
    exit 1
  fi

  exit 0
}

on () {
  echo "[SCREEN] Powering on"
  echo "on 0" | /usr/local/bin/cec-client -s
}

off () {
  echo "[SCREEN] Powering off"
  echo "standby 0" | /usr/local/bin/cec-client -s
}

main
