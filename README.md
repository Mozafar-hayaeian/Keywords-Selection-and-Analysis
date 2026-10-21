# Keywords Selection and Analysis

University NLP project for extracting keywords from biomedical abstracts and evaluating the results against author-provided keywords.

The main implementation is in the [Jupyter notebook](Project1_Keywords_Selection_and_Analysis.ipynb). Follow the steps below in order.

## Repository contents

- `Project1_Keywords_Selection_and_Analysis.ipynb` — implementation of Tasks 1–10.
- `requirements.txt` — Python packages for the main notebook environment.
- `data/database.csv` — the project's main PubMed database snapshot.
- `benchmarks/` — the three source ZIP archives used in Task 10. See [benchmarks/README.md](benchmarks/README.md).
- `results/` — saved evaluation metric tables.
- `docs/SEKE_TRAINING.md` — the training workflow for SEKE in Tasks 8 and 10.
- `docs/run_seke_task10.bat` — helper script for training SEKE on all three Task 10 datasets. Run it while the current directory is the separate SEKE repository.

## 1. Set up the main notebook environment

Use Python 3.10 or 3.11. From the project root, create an environment:

```bash
python -m venv .venv
```

Activate it:

- Windows PowerShell: `.venv\Scripts\Activate.ps1`
- macOS/Linux: `source .venv/bin/activate`

Install dependencies and launch Jupyter:

```bash
python -m pip install --upgrade pip
pip install -r requirements.txt
jupyter notebook
```

## 2. Run the PubMed tasks

The existing project database is already available at `data/database.csv`. When reproducing the saved results, **skip Task 1** so this snapshot is not overwritten by a new PubMed query.

Run the remaining notebook cells in order for Tasks 2–7. Later cells reuse functions and variables defined earlier, so they should not be run as standalone cells.

## 3. Run SEKE for Task 8

In the notebook, run Task 8, step 1 to export the PubMed training and test data for SEKE. Then follow [docs/SEKE_TRAINING.md](docs/SEKE_TRAINING.md) to train SEKE with its default configuration in the separate Conda environment. Return to the notebook and run Task 8, step 3 to evaluate the saved SEKE output.

## 4. Run Task 9

Continue to Task 9 in the notebook. It uses the PubMed database and the word2vec model for embedding features. The model download cell is optional and should only be enabled if the model file is missing.

## 5. Run Task 10

The three source benchmark archives are already in `benchmarks/`. In the notebook, run Task 10, step 1 to prepare the benchmark tables and SEKE inputs, then step 2 to add the four extractor outputs. Next, follow the Task 10 section in [docs/SEKE_TRAINING.md](docs/SEKE_TRAINING.md) to train one SEKE model for each benchmark dataset. Finally, return to the notebook and run Task 10, step 3 for evaluation.

## External SEKE dependency

SEKE is maintained in a separate upstream repository: [SEKE keyword extraction](https://github.com/matejMartinc/SEKE_keyword_extraction). This project links to SEKE and documents the workflow rather than duplicating its full source tree and separate environment. Keep the external repository cloned separately unless the course explicitly requires a bundled copy and its license permits redistribution.
