# ☕ spilltea - Terminal Demo Automation Tool

[![CI/CD Pipeline](https://github.com/JamesAtIntegratnIO/spilltea/actions/workflows/ci.yml/badge.svg)](https://github.com/JamesAtIntegratnIO/spilltea/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Shell Script](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)](https://www.gnu.org/software/bash/)

Time to spill the tea on your code! ☕ A powerful automation tool for creating professional terminal demonstrations using [demo-magic.sh](https://github.com/paxtonhare/demo-magic). This tool streamlines the entire process from recording to GIF generation with extensive customization options.

## ✨ Features

- 🎬 **Automated Demo Recording**: Record terminal sessions with simulated typing
- 🎨 **GIF Generation**: Convert recordings to shareable animated GIFs
- ⚙️ **Extensive Configuration**: Customize dimensions, speed, colors, and more
- 🔧 **Cross-Platform**: Works on macOS, Linux, and other Unix-like systems
- 📦 **Easy Installation**: One-command setup with dependency management
- 🎯 **Professional Output**: Perfect for documentation, tutorials, and presentations

## ☕ Troubleshooting

### Common Issues

**"Command not found: spilltea"**
```bash
# Make sure you've installed the tool
./install.sh
# or restart your terminal
```

**"Command not found: asciinema"**ation options.

## 🚀 Features

- **Automated Pipeline**: Record → Convert → Output in one command
- **Flexible Configuration**: Config files, environment variables, and command-line options
- **Professional Output**: Optimized GIF settings for demonstrations
- **Clean Interface**: Colored output and clear progress indicators
- **Extensible**: Easy to integrate into existing workflows
- **Cross-Platform**: Works on macOS, Linux, and Windows (with WSL)

## 📋 Prerequisites

Before using this tool, install the required dependencies:

### macOS (using Homebrew)
```bash
# Install asciinema for terminal recording
brew install asciinema

# Install pv (required by demo-magic.sh for typing effects)
brew install pv

# Install agg for GIF conversion
brew install agg
```

### Linux (Ubuntu/Debian)
```bash
# Install asciinema and pv
sudo apt update
sudo apt install asciinema pv

# Install Rust/Cargo for agg
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env

# Install agg
cargo install agg
```

### Alternative: Python pip
```bash
# Alternative asciinema installation
pip install asciinema
```

## 🚀 Installation

### Option 1: Global Installation (Recommended)
```bash
git clone https://github.com/JamesAtIntegratnIO/spilltea.git
cd spilltea

# Install globally for current user
make install
# or
./install.sh

# Now use from anywhere!
spilltea --help
```

### Option 2: System-wide Installation
```bash
# Install for all users (requires sudo)
make install-global
# or
sudo ./install.sh --global
```

### Option 3: Custom Location
```bash
# Install to custom directory
./install.sh --path ~/my-tools

# Add to your PATH manually
echo 'export PATH="~/my-tools:$PATH"' >> ~/.zshrc
```

## 🎯 Quick Start

After installation, the tool is available globally as `spilltea`:

```bash
# Time to spill some tea! ☕
spilltea --script examples/basic-demo.sh --title "My Demo"

# Or use it locally without installation
./record-demo --script examples/basic-demo.sh
```

### Basic Example

```bash
# Create a simple demo script
cat > my-demo.sh << 'EOF'
#!/usr/bin/env bash

# Include demo-magic
. ./src/demo-magic.sh

# Clear screen and start demo
clear

# Print and execute commands
pe "echo 'Hello, World!'"
pei "ls -la"
pe "pwd"

# Print without executing
p "This demonstrates the demo-magic automation tool!"
EOF

# Make it executable
chmod +x my-demo.sh

# Generate the demo (record + convert to GIF)
./record-demo --script my-demo.sh --title "My First Demo"
```

This creates:
- `demo.cast` - The asciinema recording
- `demo.gif` - The converted GIF ready for sharing

## 📖 Usage

### Command Line Interface

```bash
# After installation - time to spill some tea! ☕
spilltea [OPTIONS]

# Or run locally
./record-demo [OPTIONS]

Options:
  -h, --help              Show help message
  -c, --config FILE       Load configuration from file
  -s, --script FILE       Demo script to record
  -t, --title TITLE       Demo title
  -o, --output DIR        Output directory
  --cast-file FILE        Output cast filename
  --gif-file FILE         Output GIF filename
  --clean-only            Only clean up previous runs
  --record-only           Only record, don't convert to GIF
  --gif-only              Convert existing .cast to GIF
  --no-copy               Don't copy to output directory

GIF Options:
  --font-size SIZE        Font size (default: 14)
  --cols COLS            Terminal columns (default: 100)
  --rows ROWS            Terminal rows (default: 30) 
  --theme THEME          Color theme (default: monokai)
  --speed SPEED          Playback speed multiplier (default: 1.5x)
```

### Configuration File

Create a config file for consistent settings:

```bash
# demo.conf
DEMO_SCRIPT="my-awesome-demo.sh"
DEMO_TITLE="My Awesome Demo"
OUTPUT_DIR="./output"
FONT_SIZE=16
COLS=120
ROWS=35
THEME="solarized-dark"
SPEED=2.0
```

Then use it:
```bash
./record-demo --config demo.conf
```

### Environment Variables

Set defaults via environment:
```bash
export DEMO_SCRIPT="default-demo.sh"
export DEMO_TITLE="Default Demo"
export OUTPUT_DIR="~/demos"
./record-demo
```

## 🎭 Writing Demo Scripts

Demo scripts use [demo-magic.sh](https://github.com/paxtonhare/demo-magic) functions:

### Basic Functions

```bash
#!/usr/bin/env bash

# Include demo-magic
. ./src/demo-magic.sh

# Clear screen
clear

# Print and Execute: waits for ENTER, types command, waits for ENTER, executes
pe "ls -la"

# Print and Execute Immediately: types command, executes immediately  
pei "pwd"

# Print only: types command but doesn't execute it
p "echo 'This is just for show'"

# Wait for user input
wait

# Execute command behind the scenes (not shown)
mkdir -p temp-dir
```

### Advanced Example

```bash
#!/usr/bin/env bash

. ./src/demo-magic.sh

# Configuration
TYPE_SPEED=50
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W ${COLOR_RESET}"

clear

echo "🚀 Welcome to My Project Demo"
echo "============================="
sleep 2

pe "# Let's start by checking our environment"
pe "node --version"
pe "npm --version"

echo ""
echo "📦 Installing dependencies..."
sleep 1

pei "npm install"

echo ""
echo "🏗️  Building the project..."
sleep 1

pe "npm run build"

echo ""
echo "🧪 Running tests..."
pe "npm test"

echo ""
echo "✨ Demo complete! Your project is ready."
```

## 🎨 Themes and Customization

### Available Themes
- `monokai` (default)
- `solarized-dark`
- `solarized-light`  
- `github-dark`
- `github-light`
- `dracula`
- `nord`

### GIF Optimization Tips

For **presentations**:
```bash
./record-demo --font-size 16 --cols 80 --rows 24 --speed 1.2
```

For **documentation**:
```bash  
./record-demo --font-size 12 --cols 120 --rows 30 --speed 2.0
```

For **social media**:
```bash
./record-demo --font-size 14 --cols 100 --rows 25 --speed 1.8
```

## 📁 Project Structure

```
spilltea/
├── record-demo              # Main automation script
├── src/
│   └── demo-magic.sh       # Demo magic library
├── examples/
│   ├── basic-demo.sh       # Simple example
│   ├── advanced-demo.sh    # Complex example
│   └── config-example.conf # Configuration example
├── docs/
│   ├── EXAMPLES.md         # More examples
│   └── TROUBLESHOOTING.md  # Common issues
├── scripts/
│   └── setup.sh           # Setup script
├── README.md              # This file
└── LICENSE                # MIT License + attributions
```

## 🔧 Examples

See the `examples/` directory for complete working examples:

- **Basic Demo** (`examples/basic-demo.sh`) - Simple command demonstration
- **Advanced Demo** (`examples/advanced-demo.sh`) - Complex workflow with multiple steps
- **Configuration** (`examples/config-example.conf`) - Sample configuration file

## 🐛 Troubleshooting

### Common Issues

**"Command not found: asciinema"**
```bash
# Install asciinema
brew install asciinema  # macOS
# or
pip install asciinema   # Cross-platform
```

**"Command not found: agg"**
```bash
# macOS
brew install agg

# Linux - requires Rust/Cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install agg
```

**Large GIF file sizes**
```bash
# Reduce dimensions and increase speed
./record-demo --cols 80 --rows 20 --speed 2.5
```

**Demo script not found**
```bash
# Make sure your script exists and is executable
chmod +x your-demo.sh
./record-demo --script your-demo.sh
```

## � Testing

### Local Testing

Before contributing, run the local test suite:

```bash
# Run all local tests
./test-local.sh
```

This will validate:
- ✅ Required files and permissions
- ✅ Shell script syntax (if shellcheck available)
- ✅ Dependency availability
- ✅ Installation process
- ✅ Basic functionality
- ✅ Demo recording and output generation

### CI/CD Pipeline

Every push and pull request automatically runs comprehensive tests:

- **Multi-Platform Testing**: Ubuntu, macOS
- **Dependency Installation**: Validates `setup.sh` and `make install`
- **Functional Tests**: Creates and runs actual demos
- **Error Handling**: Tests edge cases and error recovery
- **Security Scanning**: Checks for common shell script vulnerabilities
- **Integration Testing**: Full end-to-end workflow validation

View the latest test results: [![CI Status](https://github.com/JamesAtIntegratnIO/spilltea/actions/workflows/ci.yml/badge.svg)](https://github.com/JamesAtIntegratnIO/spilltea/actions/workflows/ci.yml)

## �🤝 Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run `./test-local.sh` to validate locally
5. Add examples and documentation
6. Submit a pull request

All contributions must pass the automated CI/CD pipeline before merging.

## 📜 License & Attribution

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

### Third-Party Software

This tool builds upon these excellent open source projects:

- **[demo-magic.sh](https://github.com/paxtonhare/demo-magic)** by Paxton Hare (MIT License) - Interactive demo scripting
- **[asciinema](https://asciinema.org/)** (GPL v3) - Terminal session recording  
- **[agg](https://github.com/asciinema/agg)** (Apache 2.0) - Asciinema to GIF converter

## 🌟 Acknowledgments

- Thanks to [Paxton Hare](https://github.com/paxtonhare) for creating demo-magic.sh
- Thanks to the asciinema team for the excellent recording tools
- Inspired by the need for better terminal demo workflows

---

**Happy Tea Spilling!** ☕✨