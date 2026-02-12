import os
import json
import argparse

def parse_cape_json(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        data = json.load(f)
    # Example: extract process API calls
    processes = data.get('behavior', {}).get('processes', [])
    api_calls = []
    for proc in processes:
        for call in proc.get('calls', []):
            api_calls.append(call.get('api'))
    return api_calls

def main(input_dir):
    for fname in os.listdir(input_dir):
        if fname.endswith('.json'):
            fpath = os.path.join(input_dir, fname)
            apis = parse_cape_json(fpath)
            print(f"{fname}: {len(apis)} API calls found.")

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Parse CAPEv2 JSON logs.")
    parser.add_argument('--input_dir', type=str, required=True, help='Directory with CAPEv2 JSON files')
    args = parser.parse_args()
    main(args.input_dir)
