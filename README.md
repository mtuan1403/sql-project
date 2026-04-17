# SQL + Python Portfolio

This repository is intentionally refined to showcase my practical SQL and Python skills in a clean, review-friendly format.

## Project Focus

- SQL schema design and relational modeling
- Advanced analysis queries (joins, CTEs, aggregations, window functions)
- Data-quality validation queries
- Python automation for query execution and CSV reporting

## Repository Structure

```text
sql-project/
  README.md
  .gitignore
  sql/
    schema.sql
    seed_data.sql
    analysis_queries.sql
    data_quality_checks.sql
  python/
    run_analysis.py
    export_reports.py
  outputs/
```

## Why This Is Portfolio-Ready

- **Organized:** clear separation of SQL logic and Python automation
- **Relevant:** only code that demonstrates SQL + Python capability
- **Reproducible:** one command pipeline to build DB, run analysis, export results
- **Reviewable:** concise scripts and purpose-driven SQL files

## SQL Skills Demonstrated

- Multi-table joins across transactional entities
- CTE-driven query structuring
- Aggregation for reporting and KPI extraction
- Window functions for ranking and trend analysis
- Validation rules for anomaly and quality checks

## Python Skills Demonstrated

- Programmatic database initialization
- Query orchestration from SQL files
- Result serialization to CSV
- File/path management and safe script structure

## Quick Start

Run from project root:

```bash
python3 python/run_analysis.py
python3 python/export_reports.py
```

Generated outputs:

- `outputs/analysis_results.csv`
- `outputs/data_quality_results.csv`

## Notes

- Current scripts use SQLite for easy local execution and portfolio portability.
- SQL style is PostgreSQL-compatible with minor syntax adjustments where needed.

