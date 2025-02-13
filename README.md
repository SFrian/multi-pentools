SlowHTTP Attack Tool

📌 Description

This is a CLI-based tool that performs phased Slow HTTP attacks using SlowHTTPTest. It executes different Slow HTTP attack scenarios sequentially and logs the start and end times of each attack.

⚙️ Features

Executes Slow HTTP attack scenarios step by step

Logs attack start and end times

Supports various attack parameters

🛠️ Installation

Ensure you have slowhttptest installed on your system. If not, install it using:

sudo apt update && sudo apt install slowhttptest -y

Clone this repository:

git clone https://github.com/yourusername/slowhttp-attack-tool.git
cd slowhttp-attack-tool

🚀 Usage

Run the tool with:

./slowhttp_attack.sh

Or if using Python:

python3 slowhttp_attack.py

📝 Example Attack

./slowhttptest -c 1000 -X -r 1000 -w 10 -y 20 -n 5 -z 32 -u http://someserver/somebigresource -p 5 -l 350 -e x.x.x.x:8080

🔥 Disclaimer

This tool is for educational and testing purposes only. Use responsibly and only on systems you have permission to test.
