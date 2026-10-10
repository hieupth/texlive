#!/bin/bash
set -euo pipefail

# entrypoint.sh - Runs inside the Docker container to compile LaTeX.
# Usage: entrypoint.sh [<main.tex>] [additional latexmk args...]
# Engine selection: ENGINE env var (pdflatex|xelatex|lualatex|latex|dvilua|xdv|pdfps|pdfdvi).

MAIN_TEX="${1:-}"

if [ -z "$MAIN_TEX" ]; then
    echo "texlive: no .tex file specified, auto-detecting..." >&2
    MAIN_TEX=$(find /texlive/input -maxdepth 1 -name '*.tex' -print -quit 2>/dev/null || true)
    if [ -z "$MAIN_TEX" ]; then
        echo "texlive error: no .tex file found in /texlive/input" >&2
        exit 1
    fi
fi

ENGINE="${ENGINE:-pdflatex}"

case "$ENGINE" in
    pdflatex) ENGINE_OPTS=(-pdf) ;;
    xelatex)  ENGINE_OPTS=(-xelatex) ;;
    lualatex) ENGINE_OPTS=(-lualatex) ;;
    latex)    ENGINE_OPTS=(-dvi) ;;
    dvilua)   ENGINE_OPTS=(-dvilua) ;;
    xdv)      ENGINE_OPTS=(-xdv) ;;
    pdfps)    ENGINE_OPTS=(-pdfps) ;;
    pdfdvi)   ENGINE_OPTS=(-pdfdvi) ;;
    *)
        echo "texlive error: unknown ENGINE '${ENGINE}' (supported: pdflatex, xelatex, lualatex, latex, dvilua, xdv, pdfps, pdfdvi)" >&2
        exit 2
        ;;
esac

echo "texlive: compiling ${MAIN_TEX} with ${ENGINE} ..."

EXIT_CODE=0
latexmk \
    "${ENGINE_OPTS[@]}" \
    -interaction=nonstopmode \
    -file-line-error \
    -output-directory="/texlive/output" \
    "$MAIN_TEX" "${@:2}" || EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
    echo "texlive: compilation succeeded"
else
    echo "texlive: compilation failed with exit code ${EXIT_CODE}" >&2
fi

exit $EXIT_CODE
