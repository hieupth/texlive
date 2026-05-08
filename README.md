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

Compile a specific `.tex` file:

```bash
docker run --rm \
  -v /path/to/latex/project:/texlive/input \
  -v /path/to/output:/texlive/output \
  hieupth/texlive main.tex
```

Or let texlive auto-detect the first `.tex` file in the input directory:

```bash
docker run --rm \
  -v /path/to/latex/project:/texlive/input \
  -v /path/to/output:/texlive/output \
  hieupth/texlive
```

The compiled PDF will appear in the output directory you mounted.


## License

[Apache License 2.0](LICENSE).<br>
Copyright &copy; 2026 [Hieu Pham](https://github.com/hieupth). All rights reserved.