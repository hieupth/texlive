FROM texlive/texlive:latest

LABEL maintainer="hieupth"
LABEL description="TeX Live full installation with tlmgr for texlive"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        fonts-noto \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /texlive/input /texlive/output

COPY entrypoint.sh /texlive/entrypoint.sh
RUN chmod +x /texlive/entrypoint.sh

WORKDIR /texlive/input

ENTRYPOINT ["/texlive/entrypoint.sh"]
