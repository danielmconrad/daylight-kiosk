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
  /opt/vc/bin/tvservice --preferred
  chvt 6
  chvt 7
}

off () {
  echo "[SCREEN] Powering off"
  /opt/vc/bin/tvservice --off
}

main
