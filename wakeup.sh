#!/bin/bash

cd /home/user/Desktop/rt-tests

# Run background load
./hackbench -s 4096 -l 10000 &

# Let it saturate CPU
sleep 5

echo "[*] Measuring wakeup delays..."

# Temporary file for timestamps
TMPFILE=$(mktemp)

# Launch 100 wakeups with precise timestamps
for i in {1..5000}; do
  (
    sleep 0.01
    date +%s.%N
  ) >> "$TMPFILE" &
done

# Wait for all wakeups
wait

# Calculate average time between timestamps
awk '
  NR == 1 { prev = $1; next }
  {
    diff = $1 - prev
    total += diff
    prev = $1
  }
  END {
    avg = total / (NR - 1)
    printf "Average interval: %.9f seconds\n", avg
  }
' "$TMPFILE"

rm "$TMPFILE"
