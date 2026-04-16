FROM hieupth/mamba:latest

LABEL maintainer="hieupth"
LABEL description="TeX Live full installation with tlmgr for texlive"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        perl \
        wget \
        xz-utils \
        fonts-noto \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget -qO /tmp/install-tl-unx.tar.gz \
        https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    mkdir -p /tmp/install-tl && \
    tar -xzf /tmp/install-tl-unx.tar.gz -C /tmp/install-tl --strip-components=1 && \
    printf "selected_scheme scheme-full\nTEXDIR /usr/local/texlive\nTEXMFLOCAL /usr/local/texlive/texmf-local\nTEXMFSYSCONFIG /usr/local/texlive/texmf-config\nTEXMFSYSVAR /usr/local/texlive/texmf-var\n" \
        > /tmp/install-tl/texlive.profile && \
    /tmp/install-tl/install-tl --profile=/tmp/install-tl/texlive.profile && \
    rm -rf /tmp/install-tl /tmp/install-tl-unx.tar.gz

ENV PATH="/usr/local/texlive/bin/universal-linux:${PATH}"

RUN mkdir -p /texlive/input /texlive/output

COPY entrypoint.sh /texlive/entrypoint.sh
RUN chmod +x /texlive/entrypoint.sh

WORKDIR /texlive/input

ENTRYPOINT ["/texlive/entrypoint.sh"]
