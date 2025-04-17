# rec0nyx

**rec0nyx** is an advanced web reconnaissance tool for bug bounty hunting and penetration testing.  
It automates asset discovery, subdomain enumeration, vulnerability scanning, fuzzing, and more—making recon fast, efficient, and repeatable.

---

## Features

- **Asset & Subdomain Discovery**
- **Vulnerability Scanning** (via nuclei)
- **Content Fuzzing** (via ffuf)
- **Screenshot Capture** (via gowitness)
- **Passive & Active Recon Options**
- **Custom Rate Limits, Threads, and Wordlists**
- **Safe Preset** for stealthy recon

---

## Installation

### 1. Clone the repository

```bash
git clone https://github.com/yourusername/rec0nyx.git
cd rec0nyx
```

### 2. Run the installer

```bash
chmod +x install.sh rec0nyx
./install.sh
```

Or, to install manually:

```bash
sudo cp rec0nyx /usr/local/bin/
sudo chmod +x /usr/local/bin/rec0nyx
```

---

## Usage

```bash
rec0nyx <target.com> [OPTIONS]
```

### Options

- `-h, --help`             Show help message and exit
- `-v, --version`          Show tool version and exit
- `-t, --threads NUM`      Number of threads (default: 2)
- `--rate-limit NUM`       Rate limit for requests (default: 5)
- `--timeout SEC`          Timeout in seconds (default: 15)
- `--wordlist FILE`        Wordlist for fuzzing (default: /usr/share/seclists/Discovery/Web-Content/common.txt)
- `--output DIR`           Output directory base name (default: rec0nyx)
- `--nuclei`               Enable vulnerability scanning (nuclei)
- `--fuzz`                 Enable content fuzzing (ffuf)
- `--screenshot`           Enable screenshots (gowitness)
- `--passive`              Passive mode (no active probing)
- `--severity LEVELS`      Nuclei severity (default: critical,high,medium,low)
- `--safe-preset`          Use conservative settings for stealth
- `--install-deps`         Download and install required dependencies
- `--update`               Update rec0nyx to the latest version from GitHub

### Examples

```bash
rec0nyx example.com --nuclei --fuzz --threads 5
rec0nyx --update
```

---

## Dependency Installation

To install all required dependencies (assetfinder, httpx, waybackurls, ffuf, nuclei, gowitness, seclists):

```bash
rec0nyx --install-deps
```

---

## Author

- **Cell**

---

## License

MIT License

---

## Disclaimer

**For educational and authorized security testing only!**  
The author is not responsible for any misuse or damage caused by this tool.  
See [DISCLAIMER.md](DISCLAIMER.md) for details.
