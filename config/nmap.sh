# ==============================
# Nmap Configuration File
# ==============================

# ------------------------------
# Bagian 1: Scan -sCV (Service & Version Detection)
# ------------------------------
nmap_scan_type="-A"

# Port scanning
nmap_ports=""

# Timing
nmap_timing=""

# Host discovery
nmap_host_discovery=""

# Output dengan nama file otomatis
#nmap_output="-oN logs/nmap/nmap_$(date '+%Y%m%d_%H%M%S').txt"

# Aktifkan verbosity level tinggi (-vv)
nmap_verbosity="-vv"

# Disable DNS resolution untuk mempercepat scan
nmap_no_dns=""

# Comment bagian ini jika ingin menggunakan bagian 2 atau 3
nmap_scripts=""

# ------------------------------
# Bagian 2: Scan Kerentanan Heartbleed
# ------------------------------
# Uncomment bagian ini untuk memeriksa kerentanan Heartbleed
# nmap_scan_type="-sV"
# nmap_ports="-p 443"
# nmap_scripts="--script=ssl-heartbleed"
# nmap_output="-oN logs/nmap/heartbleed_$(date '+%Y%m%d_%H%M%S').txt"

# ------------------------------
# Bagian 3: Scan Spesifik untuk HTTP
# ------------------------------
# Uncomment bagian ini untuk memeriksa informasi terkait HTTP
# nmap_scan_type="-sV"
# nmap_ports="--top-ports 100"
# nmap_scripts="--script=http-title,http-headers,http-vuln*,http-methods"
# nmap_output="-oN logs/nmap/http_scan_$(date '+%Y%m%d_%H%M%S').txt"
