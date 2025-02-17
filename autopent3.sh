#!/bin/bash

# Load configurations
source config/slowhttp.sh
source config/nmapconf.sh
#source config/nmap.sh

# Create logs directory if it doesn't exist
mkdir -p logs/slowhttp logs/nmap

# Get attacker's public IPv4
attacker_ip=$(curl -s ifconfig.me || hostname -I | awk '{print $1}')
attacker_ipv4=$(curl -4 -s ifconfig.me || dig -4 +short myip.opendns.com @resolver1.opendns.com)

# Function to log time
log_time() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $2" | tee -a "$1"
}

# File target
SLOWHTTP_TARGET_FILE="targets/targets_slowhttp.txt"
NMAP_TARGET_FILE="targets/targets_nmap.txt"

# Cek apakah file target ada sebelum eksekusi
if [[ ! -f "$SLOWHTTP_TARGET_FILE" ]]; then
    echo "File target SlowHTTP tidak ditemukan: $SLOWHTTP_TARGET_FILE"
    exit 1
fi

if [[ ! -f "$NMAP_TARGET_FILE" ]]; then
    echo "File target Nmap tidak ditemukan: $NMAP_TARGET_FILE"
    exit 1
fi

# Menghapus karakter tersembunyi (misalnya CRLF dari Windows)
dos2unix "$SLOWHTTP_TARGET_FILE" "$NMAP_TARGET_FILE" 2>/dev/null

### **PHASE 1: SlowHTTPTest Attack**
echo "### Starting PHASE 1: SlowHTTPTest Attack ###"
while IFS= read -r target_url || [[ -n "$target_url" ]]; do
    TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
    target_safe=$(echo "$target_url" | sed 's|https\?://||;s|/|_|g')
    SLOWHTTP_LOG="logs/slowhttp/${target_safe}_slowhttp_$TIMESTAMP.txt"

    log_time "$SLOWHTTP_LOG" "### PHASE 1: SlowHTTPTest Attack ###"
    log_time "$SLOWHTTP_LOG" "Starting AutoPent SlowHTTPTest attack on $target_url..."

    slowhttptest -c "$connections" "$test_type" -r "$request_rate" \
        -w "$read_timeout" -y "$write_timeout" \
        -n "$num_requests" -z "$header_size" \
        -u "$target_url" -t "$http_method" \
        -i "$interval" -x "$body_size" \
        -p "$probe_interval" -o "$output_prefix" \
        $enable_graph -l "$attack_duration" 2>&1 | tee -a "$SLOWHTTP_LOG"

    log_time "$SLOWHTTP_LOG" "SlowHTTPTest DONE ✅"
    echo "--------------------------------------------------------------------------"
done < "$SLOWHTTP_TARGET_FILE"

echo "✅ PHASE 1: SlowHTTPTest Attack COMPLETED. Proceeding to PHASE 2..."

### **PHASE 2: Nmap Scan**
echo "### Starting PHASE 2: Nmap Scan ###"
while IFS= read -r target_url || [[ -n "$target_url" ]]; do
    TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
    target_safe=$(echo "$target_url" | sed 's|https\?://||;s|/|_|g')
    NMAP_LOG="logs/nmap/${target_safe}_nmap_$TIMESTAMP.txt"

    log_time "$NMAP_LOG" "### PHASE 2: Nmap Scan ###"
    log_time "$NMAP_LOG" "Starting AutoPent Nmap scan on $target_url..."

    nmap_output="-oN logs/nmap/${target_safe}_nmap_$TIMESTAMP.txt"
    nmap $nse_ftp $target_url \
    
    log_time "$NMAP_LOG" "Nmap Scan DONE ✅"
    echo "--------------------------------------------------------------------------"
done < "$NMAP_TARGET_FILE"

echo "✅ AutoPent attack completed. Logs saved in 'logs/' directory."
