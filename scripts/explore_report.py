import argparse
import json
from pathlib import Path


def print_section(title: str) -> None:
    print("\n" + "=" * 50)
    print(title)
    print("=" * 50)


def main() -> None:
    repo_root = Path(__file__).resolve().parent.parent
    default_report = (
        repo_root
        / "data"
        / "public_small_reports"
        / "public_small_reports"
        / "00003d128a7eb859f65f5780d8fa2b5e52d472665678bf6e388e857fbaed773a.json"
    )

    parser = argparse.ArgumentParser(
        description="Inspect a CAPEv2 JSON report and print useful key structure details."
    )
    parser.add_argument(
        "report_path",
        nargs="?",
        default=str(default_report),
        help="Path to a CAPEv2 JSON report file (default: sample report in data folder)",
    )
    args = parser.parse_args()

    report_path = Path(args.report_path)
    if not report_path.exists():
        raise FileNotFoundError(f"Report file not found: {report_path}")

    with report_path.open("r", encoding="utf-8") as f:
        data = json.load(f)

    print_section("TOP-LEVEL KEYS")
    print(list(data.keys()))

    print_section("BEHAVIOR KEYS")
    if "behavior" in data:
        print(list(data["behavior"].keys()))

        if "summary" in data["behavior"]:
            print("\nBEHAVIOR.SUMMARY KEYS:")
            print(list(data["behavior"]["summary"].keys()))

        if "processes" in data["behavior"]:
            print(f"\nNumber of processes: {len(data['behavior']['processes'])}")
            if data["behavior"]["processes"]:
                print("First process keys:", list(data["behavior"]["processes"][0].keys()))
    else:
        print("No behavior key in report")

    print_section("STATIC KEYS")
    if "static" in data:
        print(list(data["static"].keys()))
    else:
        print("No static key in report")

    print_section("NETWORK KEYS")
    if "network" in data:
        print(list(data["network"].keys()))
    else:
        print("No network key in report")

    print_section("TARGET KEYS")
    if "target" in data:
        print(list(data["target"].keys()))
    else:
        print("No target key in report")


if __name__ == "__main__":
    main()
