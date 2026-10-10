# Texlive

Compile LaTeX documents in Docker containers. No local TeX Live installation needed.

## Getting Started

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/)

### Pull the image

```bash
docker pull hieupth/texlive:latest
```

### Usage

Compile a specific `.tex` file with the default engine (pdfLaTeX):

```bash
docker run --rm \
  -v /path/to/latex/project:/texlive/input \
  -v /path/to/output:/texlive/output \
  hieupth/texlive main.tex
```

Or let it auto-detect the first `.tex` file in the input directory:

```bash
docker run --rm \
  -v /path/to/latex/project:/texlive/input \
  -v /path/to/output:/texlive/output \
  hieupth/texlive
```

The compiled output will appear in the output directory you mounted.

### Selecting an engine

Set the `ENGINE` environment variable:

```bash
docker run --rm \
  -e ENGINE=xelatex \
  -v /path/to/latex/project:/texlive/input \
  -v /path/to/output:/texlive/output \
  hieupth/texlive main.tex
```

| `ENGINE` | Compiler | Output |
|---|---|---|
| `pdflatex` (default) | pdfLaTeX | PDF |
| `xelatex` | XeLaTeX | PDF |
| `lualatex` | LuaLaTeX | PDF |
| `latex` | LaTeX | DVI |
| `dvilua` | DVI LuaLaTeX | DVI |
| `xdv` | XeLaTeX | XDV |
| `pdfps` | LaTeX → dvips → ps2pdf | PDF |
| `pdfdvi` | LaTeX → dvipdf | PDF |

Any additional arguments are passed straight to `latexmk` and override the defaults, e.g. `-e '$pdf_mode=5'` or an explicit `-xelatex`:

```bash
docker run --rm \
  -v /path/to/latex/project:/texlive/input \
  -v /path/to/output:/texlive/output \
  hieupth/texlive main.tex -e '$bibtex_use=2'
```


## License

[Apache License 2.0](LICENSE).<br>
Copyright &copy; 2026 [Hieu Pham](https://github.com/hieupth). All rights reserved.
