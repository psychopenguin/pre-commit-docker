FROM python:3.9.10-alpine

# Install git
RUN apk add --no-cache git
# Install pre-commit
RUN pip install --no-cache-dir pre-commit==2.17.0
