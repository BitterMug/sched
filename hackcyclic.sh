#!/bin/bash

cd /home/user/Desktop/rt-tests
nice=$1

nice -n0 ./hackbench -g$(nproc) -l100000 &
PID1=$!
sleep 5

echo "Starting nice=$nice"
nice -n$nice ./cyclictest -t -a -D 1m
kill $PID1
