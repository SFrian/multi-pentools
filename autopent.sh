#!/bin/bash

# Load configurations
source config/slowhttp.sh
source config/nmap.sh

# Create logs directory if it doesn't exist
mkdir -p logs

# Generate unique log filenames based on timestamp
TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
SLOWHTTP_LOG="logs/slowhttp/slowhttp_log_$TIMESTAMP.txt"
NMAP_LOG="logs/nmap/nmap_log_$TIMESTAMP.txt"

# Get attacker's public IPv4
attacker_ip=$(curl -s ifconfig.me || hostname -I | awk '{print $1}')
attacker_ipv4=$(curl -4 -s ifconfig.me || dig -4 +short myip.opendns.com @resolver1.opendns.com) #publick ip address 4

# Function to log time
log_time() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $2" | tee -a "$1"
}

### PHASE 1: SlowHTTPTest Attack ###
log_time "$SLOWHTTP_LOG" "Starting AutoPent SlowHTTPTest attack on $target_url..."
log_time "$SLOWHTTP_LOG" "Type-Attack  : \"$test_type\""
log_time "$SLOWHTTP_LOG" "Target       : \"$target_url\""
log_time "$SLOWHTTP_LOG" "From         : \"$attacker_ip\""
log_time "$SLOWHTTP_LOG" "             : \"$attacker_ipv4\""
log_time "$SLOWHTTP_LOG" "Attack of    : DDoS"
log_time "$SLOWHTTP_LOG" "Time-Start   : \"$(date '+%Y-%m-%d %H:%M:%S')\""
awk 'NF' "$SLOWHTTP_LOG" > temp_log && mv temp_log "$SLOWHTTP_LOG"

# Run SlowHTTPTest
slowhttptest -c "$connections" "$test_type" -r "$request_rate" \
    -w "$read_timeout" -y "$write_timeout" \
    -n "$num_requests" -z "$header_size" \
    -u "$target_url" -t "$http_method" \
    -i "$interval" -x "$body_size" \
    -p "$probe_interval" -o "$output_prefix" \
    $enable_graph -l "$attack_duration" 2>&1 | awk 'NF' | tee -a "$SLOWHTTP_LOG"
log_time "$SLOWHTTP_LOG" "Time-End     : \"$(date '+%Y-%m-%d %H:%M:%S')\""
log_time "$SLOWHTTP_LOG" "SlowHTTPTest DONE ✅"
echo "--------------------------------------------------------------------------"

### PHASE 2: Nmap Scan ###
log_time "$NMAP_LOG" "Starting AutoPent Nmap scan on $nmap_target..."
log_time "$NMAP_LOG" "Scan-Type    : \"$nmap_scan_type\""
log_time "$NMAP_LOG" "Target       : \"$nmap_target\""
log_time "$NMAP_LOG" "From         : \"$attacker_ip\""
log_time "$NMAP_LOG" "             : \"$attacker_ipv4\""
log_time "$NMAP_LOG" "Time-Start   : \"$(date '+%Y-%m-%d %H:%M:%S')\""

# Run Nmap
nmap $nmap_scan_type $nmap_ports $nmap_timing $nmap_host_discovery \
     $nmap_output "$NMAP_LOG" $nmap_scripts $nmap_traceroute \
     $nmap_aggressive $nmap_os_detection $nmap_ipv6 $nmap_no_dns \
     "$nmap_target" 2>&1 | tee -a "$NMAP_LOG"

log_time "$NMAP_LOG" "Time-End     : \"$(date '+%Y-%m-%d %H:%M:%S')\""

echo "✅ AutoPent attack completed. Logs saved in 'logs/' directory."
