# Keywords Selection and Analysis

University NLP project on extracting and evaluating keywords from biomedical abstracts and benchmark datasets.

The notebook implements Tasks 1–10 of the project: PubMed collection, TF-IDF/RAKE/YAKE/TextRank extraction, title-based filtering, a supervised candidate ranker, word2vec features, evaluation of SEKE predictions, and evaluation on Inspec, KDD, and SemEval2017.

## Project files

- `Project1_Keywords_Selection_and_Analysis.ipynb` — main notebook, with the implementation organized by task.
- `requirements.txt` — Python packages used by the notebook.
- `data/` — generated datasets. Task 1 writes the PubMed database to `data/database.csv`; Task 10 writes processed benchmark tables under `data/benchmarks/`.
- `benchmarks/` — source ZIP files required by Task 10.
- `models/` — downloaded word2vec model files used by Tasks 6 and 9.
- `results/` — evaluation tables and precision–recall plots produced by the notebook.

## Setup

Use Python 3.10 or 3.11. From the repository directory:

```bash
python -m venv .venv
```

Activate the environment:

- Windows PowerShell: `.venv\Scripts\Activate.ps1`
- macOS/Linux: `source .venv/bin/activate`

Install the packages and start Jupyter:

```bash
python -m pip install --upgrade pip
pip install -r requirements.txt
jupyter notebook
```

Open the notebook and run the cells in order. Some later task cells reuse functions and variables defined in earlier cells, so they are not intended to be run independently.

## Data and external dependencies

### PubMed database

The Task 1 cell collects records from NCBI PubMed and writes `data/database.csv`. It uses a fixed search query and attempts to collect up to 1,000 records with author keywords. PubMed may change over time, so a newly collected database may not match the exact snapshot used for previously saved metrics.

Set the `NCBI_EMAIL` environment variable before running Task 1 if you want to provide an email address to NCBI. An NCBI API key is optional; the notebook's `API_KEY` setting can be configured locally if you have one. Do not commit personal emails or API keys.

### Benchmark datasets

Task 10 expects these ZIP files in `benchmarks/` (leave them zipped):

- `Inspec.zip`
- `kdd.zip`
- `SemEval2017.zip`

Obtain the datasets from the upstream [KeywordExtractor-Datasets repository](https://github.com/INESCTEC/KeywordExtractor-Datasets) and check its terms before use. The notebook converts them into processed CSV tables under `data/benchmarks/`.

### Word2vec model

The notebook's model-download cells fetch the PubMed 200-dimensional word2vec model from Internet Archive and extract it under `models/`. The model is large and is not expected to be committed to this repository.

### SEKE

Tasks 8 and 10 evaluate predictions from the separate [SEKE keyword-extraction implementation](https://github.com/matejMartinc/SEKE_keyword_extraction). Clone that repository alongside this project, or set the `SEKE_FOLDER` environment variable to its location. The default expected folder name is `SEKE_keyword_extraction`. If results are stored somewhere else, set `SEKE_RESULTS_FOLDER` to the results directory.

SEKE has its own heavier dependencies and should be installed and run according to its upstream instructions. The main notebook's `requirements.txt` does not install SEKE or its model dependencies.

## Outputs

The notebook writes evaluation metric CSV files and precision–recall plots under `results/`. Task 7 and Task 9 also save test predictions there. Keep the same data snapshot, split settings, and model outputs when comparing metrics across tasks.

## Notes on reproducibility

- The evaluation split used by the supervised tasks is based on `test_size=0.2` and `random_state=42`.
- Tasks 4–6 and later reuse helpers defined by earlier cells; execute the notebook from top to bottom.
- The benchmark ZIP files and the separate SEKE repository are external inputs. Results may be skipped or unavailable until their expected files are present.
- A fresh PubMed download is not guaranteed to reproduce a past run exactly. For strict comparison with past results, retain the original database snapshot and prediction files alongside the generated metrics.
