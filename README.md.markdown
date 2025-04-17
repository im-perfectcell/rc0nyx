# rec0nyx - Next-Gen Advanced Web Reconnaissance Tool

**rec0nyx** is a powerful, all-in-one Bash script for web reconnaissance, designed for security researchers and penetration testers. It automates subdomain enumeration, live host probing, URL discovery, vulnerability scanning, content fuzzing, JavaScript analysis, cloud asset enumeration, ASN mapping, and reporting. With a modular design, flexible configuration, and robust error handling, rec0nyx streamlines the reconnaissance process while offering both active and passive scanning modes.

## Features
- **Comprehensive Reconnaissance**: Integrates tools like `assetfinder`, `subfinder`, `amass`, `nuclei`, `ffuf`, `gowitness`, and more.
- **Modular Execution**: Enable/disable specific modules (e.g., subdomain enumeration, fuzzing, vulnerability scanning).
- **Passive Mode**: Perform stealthy reconnaissance without active probing.
- **Safe Preset**: Minimize detection risk with conservative settings.
- **Output Management**: Store results in a SQLite database and generate reports in Markdown, HTML, JSON, and CSV formats.
- **Notifications**: Send results to Slack, Discord, Telegram, email, or BBRF.
- **Session Resumption**: Resume interrupted scans using session files.
- **Configurability**: Load settings from a configuration file or command-line arguments.
- **Dependency Management**: Install required tools with a single command (root required).
- **Docker Support**: Run in a containerized environment (Docker image forthcoming).

## Requirements
- **Operating System**: Linux (Debian, Fedora, RHEL) or macOS
- **Dependencies**: 
  - Core tools: `assetfinder`, `subfinder`, `amass`, `findomain`, `dnsx`, `massdns`, `puredns`, `dnsgen`, `altdns`, `httpx`, `waybackurls`, `ffuf`, `nuclei`, `gowitness`, `sqlite3`, `getJS`, `LinkFinder`, `gf`, `trufflehog`, `cloud_enum`, `asnmap`, `S3Scanner`, `jq`, `parallel`
  - Languages: Go, Python 3, pip
  - Optional: API keys for tools like `cloud_enum` or `subfinder`
- **Wordlist**: Defaults to `/usr/share/seclists/Discovery/Web-Content/common.txt` (customizable)
- **Root Privileges**: Required for `--install-deps`

## Installation
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/rec0nyx.git
   cd rec0nyx
   ```

2. **Make Executable**:
   ```bash
   chmod +x recon.sh
   ```

3. **Install Dependencies**:
   Run the built-in dependency installer (requires root):
   ```bash
   sudo ./recon.sh --install-deps
   ```
   Alternatively, manually install the required tools listed above.

4. **(Optional) Move to PATH**:
   ```bash
   sudo cp recon.sh /usr/local/bin/recon.sh
   ```

## Usage
```bash
./recon.sh <target.com> [OPTIONS] | --input-file domains.txt
```

### Options
| Option | Description | Default |
|--------|-------------|---------|
| `-h, --help` | Show help message | - |
| `-v, --version` | Show tool version | - |
| `-t, --threads NUM` | Number of threads | 4 |
| `--rate-limit NUM` | Rate limit for requests | 10 |
| `--timeout SEC` | Timeout in seconds | 20 |
| `--wordlist FILE` | Wordlist for fuzzing | `/usr/share/seclists/Discovery/Web-Content/common.txt` |
| `--output DIR` | Output directory base name | `rec0nyx` |
| `--config FILE` | Load settings from config file | - |
| `--input-file FILE` | File with list of domains | - |
| `--nucle074 | Enable vulnerability scanning (nuclei) | Disabled |
| `--fuzz` | Enable content fuzzing (ffuf) | Disabled |
| `--screenshot` | Enable screenshots (gowitness) | Disabled |
| `--passive` | Passive mode (no active probing) | Disabled |
| `--severity LEVELS` | Nuclei severity (e.g., `critical,high`) | `critical,high,medium,low` |
| `--safe-preset` | Use conservative settings | Disabled |
| `--install-deps` | Install dependencies | - |
| `--update` | Update recon.sh from GitHub | - |
| `--notify URL` | Send results to Slack/Discord webhook | - |
| `--notify-telegram URL` | Send notification to Telegram bot | - |
| `--notify-email EMAIL` | Send notification email | - |
| `--notify-bbrf URL` | Send findings to BBRF API | - |
| `--query-db` | Query the asset database | - |
| `--resume` | Resume previous session | - |
| `--session FILE` | Specify custom session file | - |
| `--report-formats FMT` | Report formats (e.g., `md,html`) | `md,html,json,csv` |
| `--enable MODULES` | Comma-separated list of modules | All enabled |
| `--api-key-<tool> KEY` | API key for external tool (e.g., `--api-key-shodan XXXXX`) | - |

### Examples
1. **Basic Reconnaissance**:
   ```bash
   ./recon.sh example.com --threads 5 --nuclei --fuzz
   ```
   Scans `example.com` with 5 threads, enabling vulnerability scanning and fuzzing.

2. **Bulk Reconnaissance**:
   ```bash
   ./recon.sh --input-file domains.txt --config config.yaml
   ```
   Scans multiple domains listed in `domains.txt` using settings from `config.yaml`.

3. **Passive Mode with Notifications**:
   ```bash
   ./recon.sh example.com --passive --notify https://slack.webhook.url
   ```
   Performs passive reconnaissance and sends results to a Slack webhook.

4. **Install Dependencies**:
   ```bash
   sudo ./recon.sh --install-deps
   ```

5. **Query Database**:
   ```bash
   ./recon.sh example.com --query-db
   ```
   Queries the SQLite database for a previous scan of `example.com`.

## Configuration File
Create a configuration file (e.g., `config.yaml`) to persist settings:
```bash
threads=4
rate_limit=10
timeout=20
output_base=rec0nyx
wordlist=/usr/share/seclists/Discovery/Web-Content/common.txt
severity=critical,high,medium,low
custom_ua="Mozilla/5.0 (Windows NT 10.0; Win64; x64) ..."
nuclei_scan=true
fuzz=true
screenshot=false
passive=false
safe_preset=false
notify_url=https://slack.webhook.url
api_key_shodan=XXXXX
enabled_modules=subdomain_enum,probe_alive
report_formats=md,html
```

Load it with:
```bash
./recon.sh example.com --config config.yaml
```

**Note**: YAML/JSON support is limited to `key=value` parsing in v2.0.0. Future versions may add full YAML/JSON parsing.

## Output
Results are stored in a directory named `<output_base>/<domain>` (e.g., `rec0nyx/example.com`):
- **Subdirectories**: `subs`, `urls`, `vulns`, `screenshots`, `js`, `cloud`, `asn`
- **Database**: `rec0nyx.db` (SQLite)
- **Reports**: `report.md`, `report.html`, `report.json`, `report.csv`

Example report (`report.md`):
```markdown
# rec0nyx Recon Report: example.com
Generated: Thu Apr 17 10:00:00 UTC 2025

## Subdomains
- Total: 150
- Live: 50

## URLs
- Wayback: 200

## Vulnerabilities
- Total: 5
...
```

## Troubleshooting
1. **Dependency Missing**:
   - Error: `Dependency missing: <tool>`
   - Solution: Run `sudo ./recon.sh --install-deps` or manually install the missing tool.

2. **Wordlist Not Found**:
   - Error: `Wordlist not found: /usr/share/seclists/...`
   - Solution: Install `seclists` or specify a custom wordlist with `--wordlist`.

3. **Permission Denied**:
   - Error: `Please run as root or with sudo for dependency installation`
   - Solution: Use `sudo` for `--install-deps` or ensure write permissions for the output directory.

4. **Tool Version Too Old**:
   - Error: `<tool> version X.Y.Z is too old`
   - Solution: Update the tool using its package manager or Go (`go install ...@latest`).

5. **No Subdomains Found**:
   - Warning: `No subdomains found`
   - Solution: Ensure the domain is valid and try increasing `--threads` or using API keys for tools like `subfinder`.

## Docker (Planned)
A Docker image is under development to simplify dependency management. Once available, run:
```bash
docker run -it rec0nyx example.com --nuclei
```

## Contributing
Contributions are welcome! To contribute:
1. Fork the repository.
2. Create a feature branch (`git checkout -b feature-name`).
3. Commit changes (`git commit -m "Add feature"`).
4. Push to the branch (`git push origin feature-name`).
5. Open a pull request.

## License
MIT License. See [LICENSE](LICENSE) for details.

## Credits
- **Author**: Cell (with assistance from Copilot)
- **Version**: 2.0.0
- **Repository**: [https://github.com/yourusername/rec0nyx](https://github.com/yourusername/rec0nyx)

For issues or feature requests, open a ticket on GitHub or contact the author.

---
Happy recon! 🚀