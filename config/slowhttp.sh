# AutoPent Configuration File

# Target URL (Target yang akan diserang)
target_url="https://103.41.169.201/"

# Number of connections (-c : Jumlah koneksi yang dibuka)
connections=2

# Test type (-X untuk Slow Read, -T untuk Slow HTTP Post, -H untuk Slow Headers, dll.)
test_type="-H"

# Request rate (-r : Jumlah permintaan per detik)
request_rate=2

# Read/Write timeout (-w : Timeout baca, -y : Timeout tulis)
read_timeout=10
write_timeout=20

# Number of requests (-n : Jumlah total permintaan yang dikirim)
num_requests=2

# Header size (-z : Ukuran header dalam byte)
header_size=32

# HTTP Method (-t : Tipe permintaan HTTP, misalnya GET atau POST)
http_method="GET"

# Interval antar paket (-i : Waktu jeda antar permintaan dalam detik)
interval=10

# Ukuran body dalam KB (-x : Body size)
body_size=24

# Probe interval (-p : Interval deteksi server dalam detik)
probe_interval=3

# Output file prefix (-o : Nama output file)
output_prefix="slowhttp"

# Generate graph output (-g : Buat output grafik dalam CSV)
enable_graph="-g"

# Duration of the attack in seconds (-l : Durasi serangan dalam detik)
attack_duration=10
