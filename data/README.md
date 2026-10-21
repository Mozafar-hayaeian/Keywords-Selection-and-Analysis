# Data

## PubMed database

The notebook expects `database.csv` here. Task 1 can collect a fresh snapshot from PubMed, but that may not reproduce the existing evaluation tables. For exact reproduction, extract `Report_Evidence_Bundle/Data_01/database.csv` from the evidence archive and copy it to this folder. The original snapshot is not included in this repository yet.

The database contains titles, abstracts, author-provided keywords, and keyword-extraction outputs for the project tasks.

## Benchmark tables

Task 10 generates:

- `benchmarks/Inspec.csv`
- `benchmarks/kdd.csv`
- `benchmarks/SemEval2017.csv`

These are processed from the corresponding ZIP archives placed in the top-level `benchmarks/` folder. The processed tables are generated locally and are not tracked by Git.
