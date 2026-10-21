# SEKE training workflows

SEKE is trained in a separate Conda environment. The ordinary notebook environment (for example, `mozafar`) prepares input files and evaluates the output; it does not perform the SEKE model training.

## Task 8: PubMed

1. In the main notebook, run the Task 8 export cell. It writes `data/pubmed/train_all.jsonl` and `data/pubmed/test.jsonl` under the external SEKE repository. The split is the same 80/20 split used for the PubMed supervised tasks.
2. Open Anaconda Prompt and activate the environment:

   ```bat
   conda activate seke
   cd /d "C:\\path\\to\\SEKE_keyword_extraction"
   ```

3. Preprocess the exported files:

   ```bat
   python preprocessing.py --input_path data\pubmed\train_all.jsonl --output_path data\pubmed\train_all_tokens.jsonl
   python preprocessing.py --input_path data\pubmed\test.jsonl --output_path data\pubmed\test_tokens.jsonl
   ```

4. The final Task 8 run in the project used the original default sequence length (256 tokens) and batch size (8), with the MoE and RNN options:

   ```bat
   python train.py --run_name pubmed_moe_rnn_default --valid_path data\pubmed\train_all_tokens.jsonl --test_path data\pubmed\test_tokens.jsonl --moe --rnn
   ```

5. This run writes `results\pubmed_moe_rnn_default_seed_42.tsv` in the SEKE repository. Return to the notebook and run the Task 8 evaluation cell. Its `SEKE_RESULTS_FOLDER` setting must point to the SEKE `results` directory.

The earlier 512-token experiment was tied to a stale PubMed snapshot and should not be mixed with the final default-config run.

## Task 10: three benchmark datasets

Task 10 uses independent data splits and trains three separate SEKE models: one for Inspec, one for KDD, and one for SemEval2017. They run sequentially, not simultaneously.

1. In the main notebook, run Task 10 step 1. It reads the three original ZIP archives from `benchmarks/`, creates `data/benchmarks/*.csv`, and writes `data/Inspec/`, `data/kdd/`, and `data/SemEval2017/` JSONL inputs inside the SEKE repository.
2. In the normal notebook environment, run Task 10 step 2 to add the four extractor columns to the benchmark CSVs. This step is required before Task 10 step 3.
3. In Anaconda Prompt, activate `seke`, change to the SEKE repository directory, and run the batch file:

   ```bat
   run_seke_task10.bat
   ```

   The batch file preprocesses the training/test JSONL files and trains one model per dataset. It writes:
   - `results\task10_Inspec_seed_42.tsv`
   - `results\task10_kdd_seed_42.tsv`
   - `results\task10_SemEval2017_seed_42.tsv`

   Completed runs are skipped if their expected output file already exists. If a run fails, read the error, fix it, and run the batch file again.

4. Return to the notebook, run Task 10 step 3, and check the printed row-order checks and saved metrics/plots. Do not compare a SEKE result if the row-order check does not match the test split.

## Important distinction

The notebook can prepare benchmark data and evaluate SEKE output, but it cannot produce the SEKE prediction TSVs without the separate training commands above. The Conda environment is needed only for SEKE preprocessing/training; keep it separate from the notebook environment.
