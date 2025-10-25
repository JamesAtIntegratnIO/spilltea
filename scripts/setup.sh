#!/usr/bin/env bash

################################################################################
# Demo Magic Automation Tool - One-line Setup
#
# This script handles the complete setup process including:
# 1. Dependency installation (if needed)
# 2. Tool installation to PATH
# 3. Verification
#
# Usage:
#   curl -sSL https://raw.githubusercontent.com/JamesAtIntegratnIO/spilltea/main/scripts/setup.sh | bash
#   # or
#   ./setup.sh
################################################################################

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m'

print_status() { echo -e "${BLUE}[INFO]${NC} $1"; }
print_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }
print_header() { echo -e "${PURPLE}$1${NC}"; }

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
        echo "windows"
    else
        echo "unknown"
    fi
}

# Install dependencies for macOS
install_deps_macos() {
    print_status "Installing dependencies for macOS..."
    
    # Check for Homebrew
    if ! command -v brew >/dev/null 2>&1; then
        print_status "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    
    # Install asciinema
    if ! command -v asciinema >/dev/null 2>&1; then
        print_status "Installing asciinema..."
        brew install asciinema
    fi
    
    # Install pv (required by demo-magic.sh)
    if ! command -v pv >/dev/null 2>&1; then
        print_status "Installing pv (required by demo-magic.sh)..."
        brew install pv
    fi
    
    # Install agg (GIF generator)
    if ! command -v agg >/dev/null 2>&1; then
        print_status "Installing agg (GIF generator)..."
        brew install agg
    fi
}

# Install dependencies for Linux
install_deps_linux() {
    print_status "Installing dependencies for Linux..."
    
    # Detect package manager and install dependencies
    if command -v apt >/dev/null 2>&1; then
        # Debian/Ubuntu
        sudo apt update
        sudo apt install -y python3-pip curl pv
        pip3 install asciinema
        
        # Install agg via cargo (not available in apt)
        if ! command -v cargo >/dev/null 2>&1; then
            print_status "Installing Rust (for agg)..."
            curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
            source ~/.cargo/env
        fi
        
        if ! command -v agg >/dev/null 2>&1; then
            print_status "Installing agg (GIF generator)..."
            cargo install agg
        fi
        
    elif command -v yum >/dev/null 2>&1; then
        # RHEL/CentOS/Fedora
        sudo yum install -y python3-pip curl pv
        pip3 install asciinema
        
        # Install agg via cargo
        if ! command -v cargo >/dev/null 2>&1; then
            print_status "Installing Rust (for agg)..."
            curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
            source ~/.cargo/env
        fi
        
        if ! command -v agg >/dev/null 2>&1; then
            print_status "Installing agg (GIF generator)..."
            cargo install agg
        fi
        
    elif command -v pacman >/dev/null 2>&1; then
        # Arch Linux
        sudo pacman -S --noconfirm asciinema pv
        
        # Install agg via cargo
        if ! command -v cargo >/dev/null 2>&1; then
            print_status "Installing Rust (for agg)..."
            curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
            source ~/.cargo/env
        fi
        
        if ! command -v agg >/dev/null 2>&1; then
            print_status "Installing agg (GIF generator)..."
            cargo install agg
        fi
        
    else
        print_warning "Could not detect package manager. Please install dependencies manually:"
        print_status "  - asciinema (terminal recorder)"
        print_status "  - pv (pipe viewer, required by demo-magic.sh)"
        print_status "  - agg (GIF converter): cargo install agg"
    fi
}

# Check if we're in the correct directory or need to clone
ensure_repo() {
    if [[ -f "install.sh" && -f "record-demo" ]]; then
        print_success "Repository found in current directory!"
        return 0
    fi
    
    print_status "Repository not found locally. Cloning..."
    
    # Clone the spilltea repository
    local repo_url="https://github.com/JamesAtIntegratnIO/spilltea.git"
    
    if command -v git >/dev/null 2>&1; then
        git clone "$repo_url" spilltea
        cd spilltea
        print_success "Repository cloned successfully!"
    else
        print_error "Git not found and repository not present locally."
        print_status "Please either:"
        print_status "  1. Install git and run this script again"
        print_status "  2. Download and extract the repository manually"
        exit 1
    fi
}

# Main setup function
main() {
    print_header "🎬 Demo Magic Automation Tool - Setup"
    print_header "======================================"
    echo ""
    
    local os=$(detect_os)
    print_status "Detected OS: $os"
    
    # Install dependencies based on OS
    case $os in
        "macos")
            install_deps_macos
            ;;
        "linux")
            install_deps_linux
            ;;
        "windows")
            print_error "Windows setup not fully automated. Please install:"
            print_status "  1. Windows Subsystem for Linux (WSL)"
            print_status "  2. Run this script inside WSL"
            exit 1
            ;;
        *)
            print_warning "Unknown OS. Please install dependencies manually:"
            print_status "  - asciinema (terminal recorder)"
            print_status "  - agg (GIF converter): cargo install agg"
            print_status "  - pv (pipe viewer, required by demo-magic.sh)"
            ;;
    esac
    
    # Ensure we have the repository
    ensure_repo
    
    # Install the tool
    print_status "Installing demo-magic tool..."
    if [[ -f "install.sh" ]]; then
        chmod +x install.sh
        ./install.sh
    else
        print_error "install.sh not found!"
        exit 1
    fi
    
    # Verify installation
    echo ""
    print_header "🧪 Verification"
    print_header "==============="
    
    # Check dependencies
    print_status "Checking dependencies:"
    command -v asciinema >/dev/null 2>&1 && print_success "✅ asciinema found" || print_warning "❌ asciinema not found"
    command -v agg >/dev/null 2>&1 && print_success "✅ agg found" || print_warning "❌ agg not found"
    command -v pv >/dev/null 2>&1 && print_success "✅ pv found" || print_warning "❌ pv not found"
    
    # Check tool installation
    if command -v demo-magic >/dev/null 2>&1; then
        if command -v spilltea >/dev/null 2>&1; then
        print_success "✅ spilltea is ready to spill some demo tea! ☕"
        
        # Test the tool
        print_status "Testing installation..."
        spilltea --help | head -3
        
        echo ""
        print_success "🎉 Setup complete!"
        print_status "Try: spilltea --script examples/basic-demo.sh"
        print_status "Time to spill the tea on your awesome code! ☕✨"
    else
        print_warning "Tool installed but may not be in PATH yet."
        print_status "Try restarting your terminal or run: source ~/.zshrc"
    fi
    else
        print_warning "Tool installed but may not be in PATH yet."
        print_status "Try restarting your terminal or run: source ~/.zshrc"
    fi
}

# Run setup
main "$@"