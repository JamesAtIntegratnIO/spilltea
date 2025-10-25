# Makefile for Demo Magic Automation Tool
# =======================================

.PHONY: help demo basic advanced clean test install install-global uninstall setup examples

# Default target
help:
	@echo "🎬 Demo Magic Automation Tool"
	@echo "============================="
	@echo ""
	@echo "Available targets:"
	@echo "  help          - Show this help message"
	@echo "  demo          - Run basic demo example"
	@echo "  basic         - Generate GIF from basic demo"
	@echo "  advanced      - Generate GIF from advanced demo"
	@echo "  clean         - Clean up demo files"
	@echo "  test          - Test the tool setup"
	@echo "  examples      - Show available examples"
	@echo "  setup         - Check and install dependencies"
	@echo ""
	@echo "Installation targets:"
	@echo "  install       - Install spilltea to ~/.local/bin (user)"
	@echo "  install-global - Install spilltea to /usr/local/bin (system-wide)"
	@echo "  uninstall     - Remove spilltea installation"
	@echo ""
	@echo "Usage examples:"
	@echo "  make demo                    # Quick test with basic demo"
	@echo "  make basic                   # Generate basic demo GIF"
	@echo "  make advanced                # Generate advanced demo GIF"
	@echo "  make install                 # Install globally available tool"

# Quick demo test (just run, don't record)
demo:
	@echo "🎬 Running basic demo (no recording)..."
	@./examples/basic-demo.sh

# Generate GIF from basic demo
basic:
	@echo "📹 Recording basic demo..."
	@./record-demo \
		--script examples/basic-demo.sh \
		--title "Basic Demo Magic Example" \
		--gif-file basic-demo.gif \
		--font-size 14 \
		--cols 100 \
		--rows 30

# Generate GIF from advanced demo  
advanced:
	@echo "📹 Recording advanced demo..."
	@./record-demo \
		--script examples/advanced-demo.sh \
		--title "Advanced Demo Magic Workflow" \
		--gif-file advanced-demo.gif \
		--font-size 16 \
		--cols 120 \
		--rows 35 \
		--speed 1.8

# Clean up generated files
clean:
	@echo "🧹 Cleaning up demo files..."
	@rm -f *.cast *.gif
	@rm -rf demo-project temp-demo-dir
	@echo "✅ Cleanup complete!"

# Test the setup
test:
	@echo "🧪 Testing demo magic automation setup..."
	@echo ""
	@echo "Checking dependencies:"
	@command -v asciinema >/dev/null 2>&1 && echo "✅ asciinema found" || echo "❌ asciinema not found"
	@command -v agg >/dev/null 2>&1 && echo "✅ agg found" || echo "❌ agg not found"
	@command -v pv >/dev/null 2>&1 && echo "✅ pv found" || echo "❌ pv not found (required by demo-magic.sh)"
	@test -f src/demo-magic.sh && echo "✅ demo-magic.sh found" || echo "❌ demo-magic.sh not found"
	@test -x record-demo && echo "✅ record-demo is executable" || echo "❌ record-demo not executable"
	@echo ""
	@echo "Testing record-demo help:"
	@./record-demo --help | head -3

# Show available examples
examples:
	@echo "📚 Available demo examples:"
	@echo ""
	@ls -la examples/
	@echo ""
	@echo "To run an example:"
	@echo "  ./examples/basic-demo.sh      # Interactive basic demo"
	@echo "  ./examples/advanced-demo.sh   # Interactive advanced demo"
	@echo ""
	@echo "To generate GIFs:"
	@echo "  make basic                    # Generate basic-demo.gif"
	@echo "  make advanced                 # Generate advanced-demo.gif"

# Setup dependencies (macOS focused)
setup:
	@echo "🔧 Setting up Demo Magic Automation Tool..."
	@echo ""
	@echo "Checking for Homebrew..."
	@command -v brew >/dev/null 2>&1 || (echo "❌ Homebrew not found. Install from https://brew.sh" && exit 1)
	@echo "✅ Homebrew found"
	@echo ""
	@echo "Installing asciinema..."
	@brew list asciinema >/dev/null 2>&1 || brew install asciinema
	@echo "✅ asciinema ready"
	@echo ""
	@echo "Installing pv (required by demo-magic.sh)..."
	@brew list pv >/dev/null 2>&1 || brew install pv
	@echo "✅ pv ready"
	@echo ""
	@echo "Checking for Rust/Cargo..."
	@command -v cargo >/dev/null 2>&1 || (echo "❌ Cargo not found. Install Rust from https://rustup.rs/" && exit 1)
	@echo "✅ Cargo found"
	@echo ""
	@echo "Installing agg..."
	@command -v agg >/dev/null 2>&1 || cargo install agg
	@echo "✅ agg ready"
	@echo ""
	@echo "🎉 Setup complete! Run 'make test' to verify."

# Installation targets
install:
	@echo "📦 Installing spilltea for current user..."
	@./install.sh --force

install-global:
	@echo "📦 Installing spilltea system-wide..."
	@sudo ./install.sh --global

uninstall:
	@echo "🗑️  Uninstalling spilltea..."
	@./install.sh --uninstall

# Custom demo with user-provided script
custom:
	@read -p "Enter demo script path: " script; \
	read -p "Enter demo title: " title; \
	./record-demo --script "$$script" --title "$$title"