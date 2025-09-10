@echo off
REM ===== run.bat — analysis-EDA =====
REM Automatiza tarefas do projeto no Windows

SET VENV=.venv
SET PY=%VENV%\Scripts\python.exe
SET PIP=%VENV%\Scripts\pip.exe
SET CSV=data\movies.csv
SET MODEL=models\models.pkl
SET OUTPUT=predictions.csv

IF "%1"=="" GOTO help

REM --------------------
REM Comandos principais
REM --------------------
IF /I "%1"=="venv" GOTO venv
IF /I "%1"=="install" GOTO install
IF /I "%1"=="train" GOTO train
IF /I "%1"=="predict" GOTO predict
IF /I "%1"=="test" GOTO test
IF /I "%1"=="clean" GOTO clean
IF /I "%1"=="help" GOTO help

ECHO Comando desconhecido: %1
GOTO help

REM --------------------
REM Criar ambiente virtual
REM --------------------
:venv
python -m venv %VENV%
ECHO Ambiente virtual criado em %VENV%
GOTO eof

REM --------------------
REM Instalar dependências
REM --------------------
:install
IF NOT EXIST %VENV% (
    ECHO Ambiente %VENV% não existe. Criando...
    python -m venv %VENV%
)
%PIP% install --upgrade pip
%PIP% install -r requirements.txt
ECHO Dependências instaladas
GOTO eof

REM --------------------
REM Treinar modelos
REM --------------------
:train
%PY% src\train.py --csv %CSV% --model %MODEL%
GOTO eof

REM --------------------
REM Gerar predições
REM --------------------
:predict
%PY% src\predict.py --csv %CSV% --model %MODEL% --out %OUTPUT%
GOTO eof

REM --------------------
REM Rodar testes automatizados
REM --------------------
:test
pytest tests/
GOTO eof

REM --------------------
REM Limpar arquivos temporários e modelos
REM --------------------
:clean
IF EXIST %OUTPUT% DEL %OUTPUT%
IF EXIST %MODEL% DEL %MODEL%
rmdir /S /Q __pycache__ 2>nul
rmdir /S /Q .pytest_cache 2>nul
rmdir /S /Q .mypy_cache 2>nul
ECHO Limpeza concluída
GOTO eof

REM --------------------
REM Ajuda
REM --------------------
:help
ECHO.
ECHO Uso: run.bat [comando]
ECHO Comandos disponíveis:
ECHO   venv     - criar ambiente virtual
ECHO   install  - instalar dependências
ECHO   train    - treinar modelos
ECHO   predict  - gerar predições
ECHO   test     - rodar testes automatizados
ECHO   clean    - limpar arquivos temporários e modelos antigos
ECHO   help     - mostrar esta ajuda
ECHO.
GOTO eof

:eof
