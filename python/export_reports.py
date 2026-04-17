#!/usr/bin/env python3
from pathlib import Path
import csv
import sqlite3


ROOT = Path(__file__).resolve().parents[1]
SQL_DIR = ROOT / "sql"
OUTPUT_DIR = ROOT / "outputs"
DB_PATH = OUTPUT_DIR / "portfolio.db"


def read_query_blocks(path: Path) -> list[str]:
    with path.open("r", encoding="utf-8") as handle:
        return [block.strip() for block in handle.read().split(";") if block.strip()]


def export_query_set(
    conn: sqlite3.Connection,
    queries: list[str],
    destination: Path,
    report_prefix: str,
) -> None:
    with destination.open("w", newline="", encoding="utf-8") as csv_file:
        writer = csv.writer(csv_file)
        writer.writerow(["report", "row_number", "data"])

        for index, query in enumerate(queries, start=1):
            cursor = conn.execute(query)
            rows = cursor.fetchall()
            for row_number, row in enumerate(rows, start=1):
                writer.writerow([f"{report_prefix}_{index}", row_number, repr(row)])


def main() -> None:
    OUTPUT_DIR.mkdir(exist_ok=True)
    if not DB_PATH.exists():
        raise FileNotFoundError(
            "Database not found. Run `python3 python/run_analysis.py` first."
        )

    conn = sqlite3.connect(DB_PATH)
    try:
        analysis_queries = read_query_blocks(SQL_DIR / "analysis_queries.sql")
        quality_queries = read_query_blocks(SQL_DIR / "data_quality_checks.sql")

        export_query_set(
            conn,
            analysis_queries,
            OUTPUT_DIR / "analysis_results.csv",
            "analysis_query",
        )
        export_query_set(
            conn,
            quality_queries,
            OUTPUT_DIR / "data_quality_results.csv",
            "quality_query",
        )
    finally:
        conn.close()

    print("Exported: outputs/analysis_results.csv")
    print("Exported: outputs/data_quality_results.csv")


if __name__ == "__main__":
    main()
