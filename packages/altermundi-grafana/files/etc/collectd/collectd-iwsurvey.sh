#!/bin/sh
hostname=$(cat /proc/sys/kernel/hostname)
for iface in $(iw dev|sed -n 's/.*Interface //p'); do
  tmpfile=/tmp/collectd-iwsurvey-${iface}.vars
  eval $(cat $tmpfile | sed "s/^/old_/" || true)
  iw $iface survey dump \
    | grep '\[in use\]' -A 5 \
    | sed -e 's/^\W//g;' \
          -e 's/:\W*/=/;' \
          -e 's/\([0-9]\+\).*$/\1/;s/ /_/g;' > $tmpfile
  eval $(cat $tmpfile)
  ### example vars set by previous command:
  # frequency=2437
  # noise=95
  # channel_active_time=8610538
  # channel_busy_time=4065889
  # channel_receive_time=3759302
  # channel_transmit_time=187392

  delta_active=$(($channel_active_time - $old_channel_active_time))
  delta_busy=$(($channel_busy_time - $old_channel_busy_time))
  delta_tx=$(($channel_transmit_time - $old_channel_transmit_time))
  delta_rx=$(($channel_receive_time - $old_channel_receive_time))
  interference_factor=$(lua -e "print(($delta_busy - $delta_tx) / ($delta_active - $delta_tx))")
 
  echo "PUTVAL ${hostname}/iwsurvey/iwsurvey-${iface} N:${frequency}:${noise}:${channel_active_time}:${channel_busy_time}:${channel_receive_time}:${channel_transmit_time}"
  echo "PUTVAL ${hostname}/iwsurvey/gauge-${iface}-interference N:${interference_factor}"
done
