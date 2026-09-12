echo "Add the date to the default clock format"

# The stock bar clock used to show only the weekday and time. Only touch a
# format that still matches that stock default exactly, so a right-click
# cycle or a hand-edited format is left alone.
config_file="$HOME/.config/omarchy/shell.json"

if [[ -s $config_file ]] && grep -q '"dddd HH:mm"' "$config_file"; then
  tmp=$(mktemp)

  if jq '
    walk(
      if type == "object" and .id == "omarchy.clock" and .format == "dddd HH:mm" then
        .format = "ddd d MMM HH:mm"
      else
        .
      end
    )
  ' "$config_file" >"$tmp"; then
    cat "$tmp" >"$config_file"
  else
    echo "Could not rewrite $config_file; update the clock format by hand."
  fi

  rm -f "$tmp"
fi
