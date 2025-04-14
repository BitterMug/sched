#!/bin/bash

LOGFILE="LAG_times.log"
echo "Date: $(date)" >> $LOGFILE
echo $(uname -r) >> $LOGFILE

cd /home/user/Downloads/linux-6.6-testing-compile

make clean
nice -n 0 make -j20 &
PID1=$!

cd /home/user/Desktop/rt-tests
nice=0

sleep 30

# Start test
echo "Starting test AFTER with nice $nice"
timeout 20m nice -n $nice ./cyclictest -t -a -q >> $LOGFILE

kill $PID1

