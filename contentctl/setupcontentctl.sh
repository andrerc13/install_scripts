#!/bin/bash

# Prompt for the virtual environment path
read -p "Enter the full path to the virtual environment (default: /home/$(whoami)/.venv): " VENV_PATH
VENV_PATH=${VENV_PATH:-/home/$(whoami)/.venv}

# Prompt for Python version
read -p "Enter the Python version to use (default: python3.11): " PYTHON_VERSION
PYTHON_VERSION=${PYTHON_VERSION:-python3.11}

# Update and upgrade system packages
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install required dependencies
echo "Installing required dependencies..."
sudo apt install -y $PYTHON_VERSION $PYTHON_VERSION-venv $PYTHON_VERSION-distutils curl git software-properties-common

# Create and activate the virtual environment
echo "Creating virtual environment at $VENV_PATH..."
$PYTHON_VERSION -m venv "$VENV_PATH"
source "$VENV_PATH/bin/activate"

# Upgrade pip, setuptools, and wheel
echo "Upgrading pip, setuptools, and wheel..."
pip install --upgrade pip setuptools wheel

# Install contentctl
echo "Installing contentctl..."
pip install contentctl

# Initialize contentctl
echo "Initializing contentctl..."
contentctl init

# Edit contentctl.yml
echo "Now edit the contentctl.yml file as needed (e.g., vi $PWD/contentctl.yml)"

# Validate contentctl setup
echo "Validating contentctl setup..."
contentctl validate

echo "Setup complete. Contentctl is ready to use."
echo "To activate your virtual environment, run:"
echo "source $VENV_PATH/bin/activate"
