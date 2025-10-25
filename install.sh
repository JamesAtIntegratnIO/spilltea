#!/usr/bin/env bash

################################################################################
# Demo Magic Automation Tool - Installation Script
#
# This script installs the demo-magic automation tool to make it globally
# available in your shell PATH.
#
# Usage:
#   ./install.sh                    # Install to ~/.local/bin
#   ./install.sh --global           # Install to /usr/local/bin (requires sudo)  
#   ./install.sh --path /custom     # Install to custom directory
#   ./install.sh --uninstall        # Remove installation
#   ./install.sh --force            # Force reinstall without prompting
################################################################################

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Default installation directory
DEFAULT_INSTALL_DIR="$HOME/.local/bin"
GLOBAL_INSTALL_DIR="/usr/local/bin"

# Tool information
TOOL_NAME="spilltea"
TOOL_VERSION="1.0.0"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${PURPLE}$1${NC}"
}

# Function to check if directory is in PATH
is_in_path() {
    local dir="$1"
    case ":$PATH:" in
        *":$dir:"*) return 0 ;;
        *) return 1 ;;
    esac
}

# Function to detect shell and suggest PATH addition
suggest_path_addition() {
    local install_dir="$1"
    local shell_config=""
    
    # Detect shell configuration file
    case "$SHELL" in
        */zsh)
            shell_config="$HOME/.zshrc"
            ;;
        */bash)
            if [[ -f "$HOME/.bashrc" ]]; then
                shell_config="$HOME/.bashrc"
            elif [[ -f "$HOME/.bash_profile" ]]; then
                shell_config="$HOME/.bash_profile"
            fi
            ;;
        */fish)
            shell_config="$HOME/.config/fish/config.fish"
            ;;
    esac
    
    if [[ -n "$shell_config" ]]; then
        print_warning "The installation directory is not in your PATH."
        print_status "To add it, run:"
        echo "  echo 'export PATH=\"$install_dir:\$PATH\"' >> $shell_config"
        echo "  source $shell_config"
        echo ""
        print_status "Or restart your terminal."
    else
        print_warning "Could not detect shell configuration file."
        print_status "Add this to your shell configuration:"
        echo "  export PATH=\"$install_dir:\$PATH\""
    fi
}

# Function to create wrapper script
create_wrapper() {
    local install_dir="$1"
    local wrapper_path="$install_dir/$TOOL_NAME"
    
    print_status "Creating wrapper script at $wrapper_path"
    
    cat > "$wrapper_path" << EOF
#!/usr/bin/env bash

################################################################################
# spilltea - Terminal Demo Automation Tool
#
# This wrapper script allows the spilltea tool to be run from anywhere
# while maintaining access to its source files and dependencies.
#
# Time to spill some tea about your code! ☕
#
# Installed from: $SCRIPT_DIR
# Installation date: $(date)
# Version: $TOOL_VERSION
################################################################################

# Tool installation directory
TOOL_DIR="$SCRIPT_DIR"

# Check if tool directory exists
if [[ ! -d "\$TOOL_DIR" ]]; then
    echo "Error: Tool directory not found: \$TOOL_DIR" >&2
    echo "The demo-magic tool may have been moved or deleted." >&2
    echo "Please reinstall or update the installation." >&2
    exit 1
fi

# Check if main script exists
if [[ ! -f "\$TOOL_DIR/record-demo" ]]; then
    echo "Error: Main script not found: \$TOOL_DIR/record-demo" >&2
    exit 1
fi

# Change to tool directory and run the main script
cd "\$TOOL_DIR" && ./record-demo "\$@"
EOF
    
    chmod +x "$wrapper_path"
    print_success "Wrapper script created successfully!"
}

# Function to install the tool
install_tool() {
    local install_dir="$1"
    local force_global="$2"
    local force_reinstall="$3"
    
    print_header "🎬 Installing Demo Magic Automation Tool"
    print_header "========================================"
    echo ""
    
    # Check if we need sudo for global installation
    if [[ "$force_global" == "true" || "$install_dir" == "$GLOBAL_INSTALL_DIR" ]]; then
        if [[ $EUID -ne 0 ]]; then
            print_error "Global installation requires sudo privileges."
            print_status "Please run: sudo $0 --global"
            exit 1
        fi
    fi
    
    # Create installation directory if it doesn't exist
    if [[ ! -d "$install_dir" ]]; then
        print_status "Creating installation directory: $install_dir"
        mkdir -p "$install_dir"
        print_success "Directory created!"
    fi
    
    # Check if tool is already installed
    if [[ -f "$install_dir/$TOOL_NAME" ]]; then
        if [[ "$force_reinstall" == "true" ]]; then
            print_warning "Tool is already installed at $install_dir/$TOOL_NAME"
            print_status "Force reinstall requested, removing existing installation..."
            rm -f "$install_dir/$TOOL_NAME"
        else
            print_warning "Tool is already installed at $install_dir/$TOOL_NAME"
            read -p "Do you want to reinstall? (y/N): " -n 1 -r
            echo
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                print_status "Installation cancelled."
                exit 0
            fi
            rm -f "$install_dir/$TOOL_NAME"
        fi
    fi
    
    # Create wrapper script
    create_wrapper "$install_dir"
    
    # Check if installation directory is in PATH
    if ! is_in_path "$install_dir"; then
        suggest_path_addition "$install_dir"
    else
        print_success "Installation directory is already in your PATH!"
    fi
    
    echo ""
    print_success "Installation complete! 🎉"
    print_status "You can now run: $TOOL_NAME --help"
    print_status "Time to spill some tea! ☕"
    
    if is_in_path "$install_dir"; then
        print_status "Testing installation..."
        if command -v "$TOOL_NAME" >/dev/null 2>&1; then
            print_success "spilltea is ready to brew some demos! ☕"
        else
            print_warning "Tool may not be immediately available. Try restarting your terminal."
        fi
    fi
}

# Function to uninstall the tool
uninstall_tool() {
    print_header "🗑️  Uninstalling Demo Magic Automation Tool"
    print_header "=========================================="
    echo ""
    
    local found_installations=()
    local common_dirs=("$HOME/.local/bin" "/usr/local/bin" "$HOME/bin")
    
    # Search for installations in common directories
    for dir in "${common_dirs[@]}"; do
        if [[ -f "$dir/$TOOL_NAME" ]]; then
            found_installations+=("$dir")
        fi
    done
    
    if [[ ${#found_installations[@]} -eq 0 ]]; then
        print_warning "No installations found in common directories."
        print_status "If you installed to a custom location, remove manually:"
        echo "  rm /path/to/your/bin/$TOOL_NAME"
        return 0
    fi
    
    print_status "Found installations:"
    for i in "${!found_installations[@]}"; do
        echo "  $((i+1)). ${found_installations[$i]}/$TOOL_NAME"
    done
    
    echo ""
    read -p "Remove all installations? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        for dir in "${found_installations[@]}"; do
            if [[ "$dir" == "/usr/local/bin" ]]; then
                if [[ $EUID -ne 0 ]]; then
                    print_warning "Skipping $dir (requires sudo)"
                    continue
                fi
            fi
            
            print_status "Removing $dir/$TOOL_NAME"
            rm -f "$dir/$TOOL_NAME"
            print_success "Removed!"
        done
        
        print_success "Uninstallation complete!"
    else
        print_status "Uninstallation cancelled."
    fi
}

# Function to show usage
show_usage() {
    cat << EOF
Demo Magic Automation Tool - Installer

Usage: $0 [OPTIONS]

OPTIONS:
    -h, --help          Show this help message
    --global            Install globally to /usr/local/bin (requires sudo)
    --path DIR          Install to custom directory
    --uninstall         Remove existing installations
    --force             Force reinstall without prompting (useful for CI)
    
EXAMPLES:
    $0                      # Install to ~/.local/bin (recommended)
    $0 --global             # Install globally (requires sudo)
    $0 --path ~/my-tools    # Install to custom directory
    $0 --uninstall          # Remove installations

INSTALLATION LOCATIONS:
    Default: ~/.local/bin (user installation, no sudo required)
    Global:  /usr/local/bin (system-wide, requires sudo)
    Custom:  Any directory you specify

NOTES:
    - The tool will be available as 'spilltea' command
    - Original files remain in the current directory
    - Wrapper script references the original location
    - If you move this directory, reinstall the tool
EOF
}

# Main function
main() {
    local install_dir="$DEFAULT_INSTALL_DIR"
    local force_global=false
    local do_uninstall=false
    local force_reinstall=false
    
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_usage
                exit 0
                ;;
            --global)
                install_dir="$GLOBAL_INSTALL_DIR"
                force_global=true
                shift
                ;;
            --path)
                install_dir="$2"
                shift 2
                ;;
            --uninstall)
                do_uninstall=true
                shift
                ;;
            --force)
                force_reinstall=true
                shift
                ;;
            *)
                print_error "Unknown option: $1"
                show_usage
                exit 1
                ;;
        esac
    done
    
    # Execute based on options
    if [[ "$do_uninstall" == "true" ]]; then
        uninstall_tool
    else
        # Validate installation directory
        if [[ -z "$install_dir" ]]; then
            print_error "Installation directory cannot be empty"
            exit 1
        fi
        
        install_tool "$install_dir" "$force_global" "$force_reinstall"
    fi
}

# Check if we're running from the correct directory
if [[ ! -f "record-demo" || ! -f "src/demo-magic.sh" ]]; then
    print_error "This script must be run from the spilltea directory"
    print_status "Please cd to the directory containing record-demo and src/demo-magic.sh"
    exit 1
fi

# Run main function
main "$@"