# Nmap Configuration File

# Target host atau IP (bisa berupa domain atau IP)
nmap_target="103.41.169.201"

# Scan type (Pilih salah satu atau kombinasikan)
# -sS : SYN scan (default, stealthy)
# -sT : TCP connect scan
# -sU : UDP scan
# -sV : Service version detection
# -sC : Run default scripts
# -A  : Aggressive scan (includes OS detection, version detection, script scanning, and traceroute)
# -O  : OS detection
nmap_scan_type="-sS -sV -A"

# Port scanning
# -p 80,443 : Scan port tertentu
# -p-       : Scan semua port (1-65535)
# --top-ports 1000 : Scan 1000 port paling umum
nmap_ports="-p 22,80,443"

# Timing template (T0 - T5)
# T0 (Paranoid) -> Paling lambat, menghindari deteksi IDS
# T5 (Insane)   -> Paling cepat, dapat menyebabkan paket drop
nmap_timing="-T4"

# Host discovery options
# -Pn : Lewati host discovery (anggap semua host up)
# -PS : TCP SYN ping
# -PE : ICMP Echo request
nmap_host_discovery="-Pn"

# Output options (bisa dipilih salah satu atau lebih)
# -oN : Output dalam format normal
# -oX : Output dalam format XML
# -oG : Output dalam format grepable
# -oA : Simpan dalam semua format sekaligus
nmap_output="-oN"

# Output file prefix (otomatis diberi timestamp saat eksekusi)
nmap_output_prefix="nmap_scan"

# Script scanning (gunakan --script untuk memilih kategori atau script tertentu)
# --script=vuln    : Scan untuk kerentanan yang diketahui
# --script=http-*  : Jalankan semua script HTTP-related
# --script=default : Jalankan script Nmap bawaan
nmap_scripts="--script=default"

# Traceroute
# --traceroute : Jalankan traceroute untuk mengetahui jalur paket
nmap_traceroute="--traceroute"

# Aggressive scan (Menggabungkan OS detection, version detection, script scanning, dan traceroute)
# -A = -O + -sV + default scripts + traceroute
nmap_aggressive="-A"

# OS detection
# -O : Mendeteksi sistem operasi target
nmap_os_detection="-O"

# Scan IPv6 (opsional, tambahkan hanya jika perlu)
# -6 : Gunakan untuk scan IPv6
nmap_ipv6=""

# Disable DNS resolution untuk mempercepat scan
# -n : Jangan resolve hostname
nmap_no_dns="-n"

#attacker_ipv4=$(curl -4 -s ifconfig.me || dig -4 +short myip.opendns.com @resolver1.opendns.com) #publick ip address 4