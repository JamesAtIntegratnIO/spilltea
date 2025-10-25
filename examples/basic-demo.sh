#!/usr/bin/env bash

################################################################################
# Basic Demo Example
# 
# This demonstrates the basic functions of demo-magic.sh for creating
# simple terminal demonstrations.
################################################################################

# Include demo-magic (adjust path as needed)
. ./src/demo-magic.sh

# Configure demo-magic
TYPE_SPEED=40
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W ${COLOR_RESET}"

# Clear screen and start
clear

echo "🎬 Basic Demo Magic Example"
echo "=========================="
echo ""
echo "This demo shows basic demo-magic.sh functions:"
echo ""
sleep 2

# Print and Execute - waits for ENTER, shows typing, waits for ENTER, executes
pe "echo 'Hello, World!'"

# Print and Execute Immediately - shows typing, executes immediately
pei "pwd"

# Show current date
pe "date"

# List files with details
pe "ls -la"

# Print only - shows typing but doesn't execute
p "echo 'This command is just for show - not executed'"

# Wait for user
echo ""
echo "Demo complete! Press ENTER to continue..."
wait

# Execute something behind the scenes (not shown to user)
mkdir -p temp-demo-dir
echo "Created temp directory behind the scenes"

# Clean up
pe "echo 'Thanks for watching the basic demo!'"

# Remove temp directory
rm -rf temp-demo-dir