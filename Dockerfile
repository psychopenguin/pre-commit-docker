FROM python:3.10.12-alpine

# Install basic packages
# hadolint ignore=DL3018,DL3059
RUN apk add \
        --repository=https://dl-cdn.alpinelinux.org/alpine/edge/main \
        --no-cache \
        git \
        curl  \
        gcc \
        libc-dev \
        bash \
        perl

# Install pre-commit
# hadolint ignore=DL3059
RUN pip install \
        --no-cache-dir \
        pre-commit==2.17.0 \
        ruamel.yaml==0.17.21 \
        tomli==2.0.1

# Install terraform
# hadolint ignore=DL3018,DL3059
#
RUN curl -Lo ./terraform.zip \
        "https://releases.hashicorp.com/terraform/1.5.2/terraform_1.5.2_linux_amd64.zip" \
        && unzip terraform.zip \
        && chmod +x terraform \
        && mv terraform /usr/bin

# Install Terraform Docs
RUN curl -Lo ./terraform-docs.tar.gz \
        "https://github.com/terraform-docs/terraform-docs/releases/download/v0.16.0/terraform-docs-v0.16.0-$(uname)-amd64.tar.gz" \
        && tar -xzf terraform-docs.tar.gz \
        && chmod +x terraform-docs \
        && mv terraform-docs /usr/bin

# Install TFSec
RUN curl -Lo ./tfsec.tar.gz \
        "https://github.com/aquasecurity/tfsec/releases/download/v1.28.1/tfsec_1.28.1_$(uname)_amd64.tar.gz" \
        && tar -xzf tfsec.tar.gz \
        && chmod +x tfsec \
        && mv tfsec /usr/bin

# Install tflint
RUN curl -Lo ./tflint.zip \
        "https://github.com/terraform-linters/tflint/releases/download/v0.47.0/tflint_$(uname)_amd64.zip" \
        && unzip tflint.zip \
        && chmod +x tflint \
        && mv tflint /usr/bin

# Install hadolint
RUN curl -Lo ./hadolint \
        "https://github.com/hadolint/hadolint/releases/download/v2.12.0/hadolint-Linux-x86_64" \
        && chmod +x hadolint \
        && mv hadolint /usr/bin
