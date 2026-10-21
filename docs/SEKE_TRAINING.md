# SEKE training workflow: Tasks 8 and 10

SEKE is an external dependency with its own code and Conda environment. Keep it as a separate clone of the [upstream SEKE keyword-extraction repository](https://github.com/matejMartinc/SEKE_keyword_extraction); this project provides the input preparation, evaluation, and a helper script for Task 10.

Use the main notebook environment (for example, `mozafar`) for dataset preparation and evaluation. Use the separate `seke` Conda environment only for SEKE preprocessing and model training.

## Task 8: PubMed dataset

1. Open the main project notebook and run **Task 8, step 1**. It writes `train_all.jsonl` and `test.jsonl` to `data/pubmed/` inside the separate SEKE repository. The export uses the same train/test split as the PubMed supervised tasks.
2. Open Anaconda Prompt and activate the SEKE environment. Change to the root of the SEKE repository (the folder containing `train.py` and `preprocessing.py`):

   ```bat
   conda activate seke
   cd /d "C:\\path\\to\\SEKE_keyword_extraction"
   ```

3. Preprocess the two exported files:

   ```bat
   python preprocessing.py --input_path data\\pubmed\\train_all.jsonl --output_path data\\pubmed\\train_all_tokens.jsonl
   python preprocessing.py --input_path data\\pubmed\\test.jsonl --output_path data\\pubmed\\test_tokens.jsonl
   ```

4. Train the final PubMed model using SEKE's default configuration:

   ```bat
   python train.py --run_name pubmed_moe_rnn_default --valid_path data\\pubmed\\train_all_tokens.jsonl --test_path data\\pubmed\\test_tokens.jsonl --moe --rnn
   ```

   The expected output is `results\\pubmed_moe_rnn_default_seed_42.tsv` inside the SEKE repository.

5. Return to the main notebook and run **Task 8, step 3** to evaluate the saved output. If SEKE is not in the default `SEKE_keyword_extraction/` folder beside the notebook, set `SEKE_FOLDER` before starting Jupyter. If its output directory is elsewhere, set `SEKE_RESULTS_FOLDER` too.

## Task 10: Inspec, KDD, and SemEval2017

Task 10 trains a separate SEKE model for each benchmark dataset. Run these steps in order:

1. In the main notebook, run **Task 10, step 1**. It reads the three ZIP files in `benchmarks/`, creates processed CSV files under `data/benchmarks/`, and writes `train_all.jsonl` and `test.jsonl` into each dataset folder in the SEKE repository.
2. In the main notebook, run **Task 10, step 2**. It adds the TF-IDF, RAKE, YAKE, and TextRank outputs to the benchmark tables. This must be done before step 3 of Task 10.
3. Open Anaconda Prompt, activate `seke`, and change to the root of the SEKE repository:

   ```bat
   conda activate seke
   cd /d "C:\\path\\to\\SEKE_keyword_extraction"
   ```

   The helper script `run_seke_task10.bat` is in the root of this project. Run it by its full path; you do not need to copy it into the SEKE folder:

   ```bat
   call "C:\\path\\to\\Keywords-Selection-and-Analysis\\run_seke_task10.bat"
   ```

   Replace the example paths with the actual folders on your computer. The script preprocesses and trains the three datasets sequentially and writes:

   - `results\\task10_Inspec_seed_42.tsv`
   - `results\\task10_kdd_seed_42.tsv`
   - `results\\task10_SemEval2017_seed_42.tsv`

   If a dataset's expected output file already exists, the script skips that dataset. If a run stops with an error, read the error first; after fixing the cause, run the script again.

4. Return to the main notebook and run **Task 10, step 3**. Check its SEKE row-order checks and generated evaluation metrics. A result should only be compared when the prediction rows align with the expected test documents.

## Why the SEKE source is separate

This repository links to the upstream SEKE implementation instead of duplicating its full source tree and environment here. Keep the external repository cloned separately; the notebook and helper script use its paths to exchange data and result files.
