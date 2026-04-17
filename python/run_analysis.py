#!/usr/bin/env python3
from pathlib import Path
import sqlite3


ROOT = Path(__file__).resolve().parents[1]
SQL_DIR = ROOT / "sql"
OUTPUT_DIR = ROOT / "outputs"
DB_PATH = OUTPUT_DIR / "portfolio.db"


def execute_script(conn: sqlite3.Connection, script_path: Path) -> None:
    with script_path.open("r", encoding="utf-8") as handle:
        conn.executescript(handle.read())


def run_query_blocks(conn: sqlite3.Connection, query_file: Path) -> list[tuple[str, list[tuple]]]:
    with query_file.open("r", encoding="utf-8") as handle:
        raw_content = handle.read()

    blocks = [block.strip() for block in raw_content.split(";") if block.strip()]
    results = []

    for idx, block in enumerate(blocks, start=1):
        cursor = conn.execute(block)
        rows = cursor.fetchall()
        results.append((f"query_{idx}", rows))

    return results


def main() -> None:
    OUTPUT_DIR.mkdir(exist_ok=True)

    conn = sqlite3.connect(DB_PATH)
    try:
        execute_script(conn, SQL_DIR / "schema.sql")
        execute_script(conn, SQL_DIR / "seed_data.sql")
        conn.commit()

        analysis_results = run_query_blocks(conn, SQL_DIR / "analysis_queries.sql")
        quality_results = run_query_blocks(conn, SQL_DIR / "data_quality_checks.sql")

        print("Database initialized:", DB_PATH)
        print("Analysis queries executed:", len(analysis_results))
        print("Data quality queries executed:", len(quality_results))
    finally:
        conn.close()


if __name__ == "__main__":
    main()
