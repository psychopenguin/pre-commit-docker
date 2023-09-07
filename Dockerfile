FROM python:3.10.13-alpine

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
        pre-commit==3.4.0 \
        ruamel.yaml==0.17.32 \
        tomli==2.0.1

# Install terraform
# hadolint ignore=DL3018,DL3059
#
RUN LATEST_TERRAFORM=`curl -sL https://releases.hashicorp.com/terraform/index.json | jq -r '.versions[].builds[].url' | sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n | egrep -v 'rc|beta|alpha' | egrep 'linux.*amd64' | grep -v terraform_0 | tail -1` \ 
        && curl -Lo ./terraform.zip ${LATEST_TERRAFORM} \
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
        "https://github.com/terraform-linters/tflint/releases/download/v0.48.0/tflint_$(uname)_amd64.zip" \
        && unzip tflint.zip \
        && chmod +x tflint \
        && mv tflint /usr/bin

# Install hadolint
RUN curl -Lo ./hadolint \
        "https://github.com/hadolint/hadolint/releases/download/v2.12.0/hadolint-Linux-x86_64" \
        && chmod +x hadolint \
        && mv hadolint /usr/bin
