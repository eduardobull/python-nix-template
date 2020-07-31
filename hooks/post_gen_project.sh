#!/usr/bin/env bash
set -euo pipefail

echo "Creating environment"
direnv allow
nix-shell -p niv --run "niv init --latest"
nix-shell --run \
    'poetry init \
    --name {{cookiecutter.project_name}} \
    --dev-dependency ruff \
    --dev-dependency black \
    --dev-dependency isort \
    --dev-dependency ipython \
    --dev-dependency ipykernel \
    --dev-dependency ipywidgets \
    --dev-dependency watermark \
    --dev-dependency "nbqa[toolchain]" \
    && poetry install --no-root'

echo "Initializing git repository"
nix-shell --run 'git init'
nix-shell --run 'git add -A'
nix-shell --run 'git commit -m "Initial commit."'
