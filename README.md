AutoPent - Automated Web Pentesting Tool

📌 Overview

AutoPent is an automated web penetration testing tool designed to conduct multiple attack phases sequentially. It currently supports SlowHTTPTest for DoS attacks and Nmap for vulnerability scanning. The tool is configurable and allows adding new attack methods in the future.

🚀 Features

Automated attack execution for multiple targets.

Sequential attack phases, starting with SlowHTTPTest followed by Nmap scanning.

Flexible configuration using config/ files.

Logging system with structured output per target.

Easily extendable to add more attack tools.

📂 Directory Structure

AutoPent/
│── config/
│   ├── slowhttp.sh      # Configuration file for SlowHTTPTest
│   ├── nmap.sh          # Configuration file for Nmap
│── logs/
│   ├── slowhttp/        # Logs for SlowHTTPTest
│   ├── nmap/            # Logs for Nmap
│── autopent.sh          # Main script
│── README.md            # Documentation

🔧 Installation

Prerequisites

Ensure you have the following installed on your system:

Kali Linux or any Linux-based OS

SlowHTTPTest

sudo apt install slowhttptest

Nmap

sudo apt install nmap

Curl & Awk (default on most Linux systems)

sudo apt install curl gawk

Clone Repository

git clone https://github.com/yourusername/AutoPent.git
cd AutoPent
chmod +x autopent.sh

⚙️ Configuration

Edit the configuration files before running the script.

config/slowhttp.sh

Define the targets and SlowHTTPTest attack parameters:

# List of target URLs
targets=(
    "https://target1.com"
    "https://target2.com"
    "https://target3.com"
)

# SlowHTTPTest Config
test_type="-H"
connections=50
request_rate=10
read_timeout=10
write_timeout=10
num_requests=1000
header_size=4096
http_method="GET"
interval=10
body_size=52
probe_interval=3
output_prefix="slowhttp_output"
enable_graph=""
attack_duration=10

config/nmap.sh

Define the Nmap scan parameters:

nmap_scan_type="-sS"
nmap_ports="-p 80,443"
nmap_timing="-T4"
nmap_host_discovery="-Pn"
nmap_output="-oN"
nmap_scripts="--script=vuln"
nmap_traceroute="--traceroute"
nmap_aggressive="-A"
nmap_os_detection="-O"
nmap_ipv6=""
nmap_no_dns=""

🚀 Usage

Run the script to start automated penetration testing:

./autopent.sh

📜 Output

Logs are saved in the logs/ directory with timestamps:

logs/
│── slowhttp/
│   ├── target1.com_slowhttp_20250213_153000.txt
│── nmap/
│   ├── target1.com_nmap_20250213_153000.txt

🔥 Future Enhancements

Adding more attack tools (e.g., Nikto, Metasploit, SQLMap).

Implementing a web-based UI for easier configuration.

Improving logging and result analysis.

🤝 Contributing

We welcome contributions! Feel free to:

Fork the repository

Create a new branch

Submit a pull request

⚠️ Disclaimer

This tool is for educational and research purposes only. Unauthorized use against any target without explicit permission is illegal. The developers are not responsible for any misuse of this tool.

📜 License

This project is licensed under the MIT License - see the LICENSE file for details.



