#!/bin/bash

# 要 gnu-grep, pget
set -eu

case "$(uname -s)" in
"Darwin")
  cpu_cores=$(system_profiler SPHardwareDataType | grep "Total Number of Cores:" | awk '{print $NF}')
  ;;
"Linux")
  cpu_cores=$(cat /proc/cpuinfo | grep "cpu cores" | wc -l)
  ;;
esac

download_lists=$(curl -s https://www.asahi.com/articles/ASL4J669JL4JUEHF016.html | ggrep -Po '(?<=href\=").+\.pdf' | sort | uniq)
multi_process=10

echo $download_lists | xargs -P $multi_process -n 1 pget -p $cpu_cores
