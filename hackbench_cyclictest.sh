#!/bin/bash
nice=$1
nice -n0 ./hackbench -g$(nproc) -l10000000000 &
PID=$!
sleep 1

nice -n$nice ./cyclictest -D 5m
kill $PID
