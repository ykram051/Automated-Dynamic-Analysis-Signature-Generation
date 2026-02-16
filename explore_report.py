import json
import os

report_path = r"c:\Users\MSI\Downloads\cyber_security\malware lab\Automated-Dynamic-Analysis-Signature-Generation\data\public_small_reports\public_small_reports\00003d128a7eb859f65f5780d8fa2b5e52d472665678bf6e388e857fbaed773a.json"

with open(report_path) as f:
    data = json.load(f)

print("=" * 50)
print("TOP-LEVEL KEYS")
print("=" * 50)
print(list(data.keys()))

print("\n" + "=" * 50)
print("BEHAVIOR KEYS")
print("=" * 50)
if 'behavior' in data:
    print(list(data['behavior'].keys()))
    
    if 'summary' in data['behavior']:
        print("\nBEHAVIOR.SUMMARY KEYS:")
        print(list(data['behavior']['summary'].keys()))
    
    if 'processes' in data['behavior']:
        print(f"\nNumber of processes: {len(data['behavior']['processes'])}")
        if data['behavior']['processes']:
            print("First process keys:", list(data['behavior']['processes'][0].keys()))

print("\n" + "=" * 50)
print("STATIC KEYS")
print("=" * 50)
if 'static' in data:
    print(list(data['static'].keys()))

print("\n" + "=" * 50)
print("NETWORK KEYS")
print("=" * 50)
if 'network' in data:
    print(list(data['network'].keys()))
else:
    print("No network key in report")

print("\n" + "=" * 50)
print("TARGET KEY")
print("=" * 50)
if 'target' in data:
    print(list(data['target'].keys()))
