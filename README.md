# Automated Dynamic Analysis Signature Generation

**Project 3: Malware Analysis & Automated Signature Generation using LLMs**

Automated tool that generates CAPEv2 behavioral signatures from sandbox execution logs using Large Language Models (LLMs). This project combines dynamic malware analysis with LLM-driven semantic interpretation to automatically generate high-fidelity detection signatures and MITRE ATT&CK technique mappings.

**Team Members:** Ikram Benfellah, Fadel Fatima Zahra  
**Repository:** https://github.com/ykram051/Automated-Dynamic-Analysis-Signature-Generation  
**Final Submission Date:** March 22, 2026

---

## 🎯 Project Overview

### Objective
Automate the generation of CAPEv2 Python behavioral signatures and detection rules from dynamic malware analysis reports, with LLM-based semantic interpretation and MITRE ATT&CK framework mapping.

### Key Features
- **Automated Signature Generation**: Generates Python-based CAPEv2 signatures automatically
- **LLM-Driven Analysis**: Uses state-of-the-art language models for semantic behavior interpretation
- **MITRE ATT&CK Mapping**: Automatically maps detected behaviors to MITRE ATT&CK techniques
- **Comprehensive Reporting**: Generates detailed threat analysis reports with confidence scoring
- **Docker Support**: Fully containerized for easy deployment and reproducibility

### Target Use Cases
1. Security operations centers (SOCs) for rapid signature generation
2. Threat intelligence teams for malware family characterization
3. Automated malware analysis pipelines
4. Research in behavioral malware detection

---

## 📊 Dataset

**AVAST-CTU CAPEv2 Dataset (Public)**

### Dataset Statistics
- **Total Samples**: 10 malware families across 100 representative samples
- **Malware Families**: Adload, Emotet, HarHar, Lokibot, njRAT, Qakbot, Swisyn, Trickbot, Ursnif, Zeus
- **Malware Types**: Banker, Trojan, PWS (Password Stealer), Coinminer, RAT, Keylogger
- **Report Format**: CAPEv2 JSON sandbox execution reports

### Data Files
```
data/
├── public_labels.csv                          # Ground truth labels (SHA256, family, type, date)
├── train_samples.csv                          # Training set manifests
├── val_samples.csv                            # Validation set manifests
├── test_samples.csv                           # Test set manifests
├── balanced_samples.csv                       # Balanced split configuration
├── public_small_reports/                      # Original CAPEv2 JSON reports (4000+ samples)
└── llm_analysis/                              # Processed outputs and caches
    ├── capev2_signatures/                     # Generated CAPEv2 Python signatures
    ├── cache/                                 # Cached LLM analysis results
    └── analysis_checkpoint_*.json             # Checkpoint data
```

---

## 🏗️ System Architecture

### Six-Stage Pipeline

```
STAGE 1: DATA ACQUISITION
└─ data_acquisition.ipynb
   └─ Collects malware samples from sandbox reports
      └─ Output: Raw behavioral execution traces

         ↓

STAGE 2: FEATURE EXTRACTION
└─ feature_extraction.ipynb
   └─ Extracts structured behavioral features
      └─ Output: data/processed/behavior_features.csv

         ↓

STAGE 3: BEHAVIOR IR GENERATION
└─ behavior_ir.ipynb
   └─ Builds unified Behavior Intermediate Representation
      └─ Output: data/processed/behavior_ir.json

         ↓

STAGE 4: LLM SEMANTIC ANALYSIS
└─ llm_behavior_analysis.ipynb (Part 1)
   └─ LLM-based semantic interpretation
      └─ Output: Cached LLM analyses (samples + families)

         ↓

STAGE 5: SIGNATURE GENERATION & VALIDATION
└─ signature_generation_validation.ipynb (Part 2)
   └─ Generates CAPEv2 signatures & MITRE ATT&CK mappings
      └─ Output: CAPEv2 Python signatures + validation reports

         ↓

STAGE 6: FINAL EVALUATION & REPORTING
└─ final_evaluation_report.ipynb
   └─ Comprehensive evaluation with visualizations
      └─ Output: Research tables, visualizations, per-sample analysis
```

### Behavioral Features Tracked
- **Process Operations**: Process creation, termination, injection
- **Registry Operations**: Registry key creation, modification, deletion
- **File Operations**: File creation, modification, deletion
- **Network Indicators**: DNS queries, TCP connections, HTTP/HTTPS traffic
- **API Calls**: System calls grouped by category
- **Persistence Mechanisms**: Scheduled tasks, registry run keys, service creation

### MITRE ATT&CK Techniques
The system automatically identifies and maps 30+ ATT&CK techniques, including:
- Process Injection, Privilege Escalation, Defense Evasion
- Persistence, Command & Control, Exfiltration
- Discovery, Lateral Movement, and more

---

## 🚀 Quick Start

### Option 1: Docker (Recommended)

#### Using docker-compose (Easiest):
```bash
# Start services
./start.sh

# Enter the container
docker-compose exec cape-signature-gen bash

# Run a specific notebook inside the container
jupyter notebook
```

#### Manual Docker:
```bash
# Build the image
docker build -t cape-signature-gen .

# Run the container with volume mount
docker-compose up -d
```

### Option 2: Local Python Installation

```bash
# Install Python 3.10+
python --version

# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Run Jupyter
jupyter notebook
```

---

## 📚 Notebooks Guide

### Execution Order
All notebooks are designed to run sequentially. Each depends on outputs from previous stages.

| # | Notebook | Purpose | Input | Output |
|---|----------|---------|-------|--------|
| 1 | `data_acquisition.ipynb` | Load and validate dataset | Raw CAPEv2 reports | Processed training splits |
| 2 | `feature_extraction.ipynb` | Extract behavioral features | CAPEv2 reports | `behavior_features.csv` |
| 3 | `behavior_ir.ipynb` | Build Behavior IR | Feature vectors | `behavior_ir.json` |
| 4 | `llm_behavior_analysis.ipynb` (Part 1) | LLM semantic analysis | Behavior IR | Cached LLM analyses |
| 5 | `signature_generation_validation.ipynb` (Part 2) | Generate signatures | LLM analyses | CAPEv2 Python signatures |
| 6 | `final_evaluation_report.ipynb` | Comprehensive evaluation | All artifacts | Research tables & visualizations |

### Key Outputs
- **`data/processed/behavior_ir.json`**: Unified behavior representation (all 100 samples)
- **`data/llm_analysis/capev2_signatures/`**: 20 generated CAPEv2 Python signature files
- **`data/processed/behavioral_signatures.json`**: All signatures in JSON format
- **`data/llm_analysis/llm_analysis_results.json`**: Per-sample LLM analysis cache
- **`data/processed/behavior_features.csv`**: Feature matrix for analysis

---

## 📈 Research Methodology

### Research Questions
1. **Signature Quality**: What is the precision, recall, and F1-score of LLM-generated CAPEv2 signatures compared to manual signatures?
2. **Generalization**: To what extent do LLM-generated signatures detect unseen variants from new malware families?
3. **ATT&CK Accuracy**: How accurate is the automated MITRE ATT&CK technique mapping compared to expert annotation?

### Evaluation Metrics
- **Precision & Recall**: Signature detection accuracy
- **F1-Score**: Harmonic mean of precision and recall
- **Coverage Analysis**: Percentage of behaviors captured by signatures
- **Cross-Family Generalization**: Detection rate on out-of-distribution samples
- **ATT&CK Confidence**: Correctness of technique mappings

### Related Work
- **DeepSign (2017)**: Deep learning for invariant malware signatures
- **Graph-Ensemble Methods (2024)**: GNNs for API call sequence analysis
- **Automatic Malware Signature Generation**: Open-source signature automation tools

Our contribution uniquely combines:
- **LLM-driven semantic interpretation** for behavior understanding
- **Automated CAPEv2 Python signature generation** (not manual or GNN-based)
- **Integrated MITRE ATT&CK mapping** with confidence scoring
- **Comprehensive evaluation framework** with multiple metrics

---

## 📋 Project Structure

```
.
├── README.md                              # This file
├── Dockerfile                             # Docker image definition
├── docker-compose.yml                     # Docker Compose configuration
├── start.sh                               # Startup script
├── requirements.txt                       # Python dependencies (pinned versions)
├── environment.yml                        # Conda environment file
├── PIPELINE_ARCHITECTURE.txt              # Detailed pipeline documentation
├── NOTEBOOK_SPLIT_GUIDE.md                # Notebook split documentation
├── architecture_diagram.png               # System architecture diagram
│
├── data/
│   ├── public_labels.csv                  # Ground truth labels
│   ├── train_samples.csv                  # Training set configuration
│   ├── val_samples.csv                    # Validation set configuration
│   ├── test_samples.csv                   # Test set configuration
│   ├── balanced_samples.csv               # Balanced data split
│   ├── preprocessed_samples.csv           # Preprocessed sample manifest
│   ├── class_weights.csv                  # Class balancing weights
│   ├── public_small_reports/              # Original CAPEv2 JSON reports (4000+ files)
│   ├── processed/                         # Pipeline outputs
│   │   ├── behavior_features.csv          # Extracted features (all samples)
│   │   ├── behavior_ir.json               # Behavior Intermediate Representation
│   │   ├── behavior_details.json          # Detailed behavior breakdown
│   │   ├── behavior_ir_summary.csv        # Statistical summary
│   │   ├── behavioral_signatures.json     # All generated signatures
│   │   ├── detection_patterns.json        # Pattern detection results
│   │   ├── signature_summary.csv          # Signature statistics
│   │   └── behavior_ir_motifs.png         # Behavior visualization
│   └── llm_analysis/                      # LLM analysis artifacts
│       ├── capev2_signatures/             # Generated CAPEv2 Python files (20 signatures)
│       ├── capev2_signatures.json         # All signatures in JSON format
│       ├── llm_analysis_results.json      # Per-sample LLM analysis (cached)
│       ├── llm_analysis_summary.csv       # Analysis summary statistics
│       ├── family_analyses.json           # Family-level LLM analysis
│       ├── family_stats_deterministic.json # Family statistics
│       ├── detection_rules.txt            # Consolidated detection rules
│       ├── validation_metrics.json        # Validation metrics & scores
│       ├── analysis_checkpoint_50.json    # Checkpoint (50 samples)
│       ├── analysis_checkpoint_100.json   # Checkpoint (100 samples)
│       ├── analysis_checkpoint_latest.json # Latest checkpoint
│       └── cache/                         # LLM analysis caches
│           ├── samples/                   # Per-sample analyses (100 files)
│           ├── families/                  # Per-family analyses (10 files)
│           └── signatures/                # Signature generation cache
│
├── notebooks/                             # Jupyter notebooks (execution order matters)
│   ├── data_acquisition.ipynb             # [1] Load and validate data
│   ├── feature_extraction.ipynb           # [2] Extract features
│   ├── behavior_ir.ipynb                  # [3] Build Behavior IR
│   ├── llm_behavior_analysis.ipynb        # [4] LLM semantic analysis
│   ├── signature_generation_validation.ipynb # [5] Signature generation
│   └── final_evaluation_report.ipynb      # [6] Final evaluation & reporting
│
├── report.pdf                             # Final technical report (10 pages)
└── Malware_Analysis_Final_Project.pdf     # Complete project documentation
```

---

## 🔧 Installation & Setup

### Prerequisites
- **Docker** (recommended) or **Python 3.10+**
- **Git** (for repository cloning)
- **4GB+ free disk space** (for datasets and models)
- **2GB+ RAM** (minimum; 8GB+ recommended for LLM processing)

### Setup Steps

#### Step 1: Clone Repository
```bash
git clone https://github.com/ykram051/Automated-Dynamic-Analysis-Signature-Generation.git
cd Automated-Dynamic-Analysis-Signature-Generation
```

#### Step 2: Choose Installation Method

**Option A: Docker (Recommended)**
```bash
# Make start script executable
chmod +x start.sh

# Run startup script
./start.sh

# Inside container, run notebooks
docker-compose exec cape-signature-gen jupyter notebook --ip=0.0.0.0 --no-browser
```

**Option B: Local Python**
```bash
# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Start Jupyter
jupyter notebook
```

#### Step 3: Run Pipeline
```bash
# Open Jupyter and run notebooks in order:
# 1. notebooks/data_acquisition.ipynb
# 2. notebooks/feature_extraction.ipynb
# 3. notebooks/behavior_ir.ipynb
# 4. notebooks/llm_behavior_analysis.ipynb
# 5. notebooks/signature_generation_validation.ipynb
# 6. notebooks/final_evaluation_report.ipynb
```

---

## 📊 Results Summary

### Signature Generation
- **Total Signatures Generated**: 20 Python-based CAPEv2 signatures
- **Malware Families Covered**: 10 families
- **Average Samples per Signature**: 5 samples
- **Signature Quality**: Validated against original CAPEv2 behavior

### MITRE ATT&CK Mapping
- **Unique Techniques Identified**: 35+ techniques
- **Top Techniques**: 
  - Process Injection
  - Defense Evasion
  - Persistence
  - Command & Control
  - Exfiltration

### Performance Metrics
- **Feature Extraction Time**: < 5 seconds per sample
- **LLM Analysis Time**: ~2-3 seconds per sample (cached)
- **Signature Generation Time**: < 1 second per signature
- **Total Pipeline Runtime**: ~2-3 hours (full 100 samples with caching)

---

## 👥 Contributing

This is a academic research project completed as Project 3. Contributions are welcome for:
- Additional malware families
- Enhanced feature extraction
- Alternative LLM backends
- Performance optimizations

---

## 📄 License & Citation

**Academic Project**: S7 Capstone - Malware Analysis and Cybersecurity  
**Institution**: [Your University]  
**Year**: 2026

### Citing This Work
```bibtex
@article{BenfellahFatima2026,
  title={Automated Dynamic Analysis Signature Generation Using Large Language Models},
  author={Benfellah, Ikram and Fatima Zahra, Fadel},
  year={2026},
  note={Academic Capstone Project}
}
```

---

## 📞 Support & Documentation

- **Detailed Pipeline Architecture**: See [PIPELINE_ARCHITECTURE.txt](PIPELINE_ARCHITECTURE.txt)
- **Notebook Organization**: See [NOTEBOOK_SPLIT_GUIDE.md](NOTEBOOK_SPLIT_GUIDE.md)
- **Data Dictionary**: See [data/ReadMe.md](data/ReadMe.md)
- **Issues & Questions**: Use GitHub Issues or contact the team

---

## ✅ Final Submission Checklist

- [x] Complete source code
- [x] Dockerfile and docker-compose.yml
- [x] start.sh startup script
- [x] Comprehensive README (this file)
- [x] Technical documentation
- [x] Final report (PDF, max 10 pages)
- [x] Presentation slides (when available)
- [x] All notebooks properly documented
- [x] Data and outputs organized
- [x] GitHub repository with clean history