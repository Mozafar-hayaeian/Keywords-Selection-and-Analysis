@echo off
rem Task 10: preprocess and train one SEKE model per benchmark dataset, sequentially.
rem Run from Anaconda Prompt with the seke environment active, inside the SEKE repository.
call :run Inspec
if errorlevel 1 goto :stopped
call :run kdd
if errorlevel 1 goto :stopped
call :run SemEval2017
if errorlevel 1 goto :stopped
echo.
echo ALL THREE DATASETS ARE DONE
goto :eof

:run
set NAME=%1
if exist results\task10_%NAME%_seed_42.tsv (
    echo %NAME% is already finished, skipped
    exit /b 0
)
echo.
echo ===== %NAME%: preprocessing =====
python preprocessing.py --input_path data\%NAME%\train_all.jsonl --output_path data\%NAME%\train_all_tokens.jsonl
if errorlevel 1 exit /b 1
python preprocessing.py --input_path data\%NAME%\test.jsonl --output_path data\%NAME%\test_tokens.jsonl
if errorlevel 1 exit /b 1
echo.
echo ===== %NAME%: training =====
python train.py --run_name task10_%NAME% --valid_path data\%NAME%\train_all_tokens.jsonl --test_path data\%NAME%\test_tokens.jsonl --moe --rnn
if errorlevel 1 exit /b 1
exit /b 0

:stopped
echo.
echo STOPPED because of an error. Read the message above, fix it and run this file again.
echo Finished datasets are skipped automatically.
