#!/usr/bin/env bash

echo "----- Hostname -----"
hostnamectl
echo ""

echo "----- CPU Info -----"
cat /proc/cpuinfo | grep 'model name\|cpu cores'
echo ""

echo "----- Memory Info -----"
free -h
echo ""

echo "----- Disk Space Info -----"
df -h /
echo ""

echo "----- Network Info -----"
ip addr | grep 'inet '
echo ""
