#!/bin/sh

# Get active connections
connections=$(netstat -t -u | tr -s ' ' ' ' | awk -F ' ' '{print $5}' | tr -s '\n' ' ')
IFS=" "

# Turn it into an array
connections=($connections)

# Loop through the connections, skipping the first two elements
# since they're useless.
for i in "${connections[@]:3}"; do

  # Strip out the port number
  filtered=$(echo $i | sed 's/:[0-9]*//g')
  echo "mtr $filtered"

  # Run mtr.
  mtr "$filtered"
done
