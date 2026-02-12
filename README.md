# Automated Dynamic Analysis Signature Generation

Automated tool that generates CAPEv2 signatures from sandbox execution logs using LLMs.

## Quick Start

1. Build the Docker image:
   ```
   docker build -t cape-signature-gen .
   ```

2. Run the container (mounts your project directory):
   ```
   docker run -it --rm -v "${PWD}:/app" cape-signature-gen
   ```

3. Run the parser (inside the container):
   ```
   python src/parse_cape.py --input_dir data/public_small_reports/public_small_reports
   ```

## Dataset

Using the AVAST-CTU CAPEv2 Dataset:
- **public_labels.csv**: Labels with sha256, malware family, type, and detection date
- **public_small_reports/public_small_reports/**: CAPEv2 JSON reports (reduced version)

Dataset contains:
- 48,976 malicious file reports
- 6 malware types: banker, trojan, pws, coinminer, rat, keylogger
- 10 malware families: Adload, Emotet, HarHar, Lokibot, njRAT, Qakbot, Swisyn, Trickbot, Ursnif, Zeus

## Requirements

- Docker (recommended)
- Or: Python 3.10+, see requirements.txt

## Project Structure

```
├── src/               # Source code
│   └── parse_cape.py  # CAPEv2 log parser
├── data/              # Dataset
│   ├── public_labels.csv
│   └── public_small_reports/
├── notebooks/         # Jupyter notebooks for exploration
├── Dockerfile
└── requirements.txt
```