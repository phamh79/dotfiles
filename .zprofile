if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -lt 3 ]]; then
  exec startx
fi
