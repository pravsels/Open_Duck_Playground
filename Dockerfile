FROM nvidia/cuda:12.1.0-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive
# Set PATH early so that uv is found in later commands.
ENV PATH="/root/.local/bin:${PATH}"

# Install system tools, Python 3.11, pip, etc. in one RUN.
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      software-properties-common \
      curl \
      git && \
    add-apt-repository ppa:deadsnakes/ppa -y && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
      python3.11 \
      python3.11-distutils \
      python3.11-dev && \
    rm -rf /var/lib/apt/lists/* && \
    curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11 && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.11 1 && \
    python -m pip install --upgrade pip

WORKDIR /open_duck
# Copy your entire project. (Make sure you have a proper .dockerignore to exclude unneeded files.)
COPY . .

# Combine uv installation and virtual environment sync in one RUN.
RUN curl -LsSf https://astral.sh/uv/install.sh | sh && uv sync --frozen

CMD ["bash"]
