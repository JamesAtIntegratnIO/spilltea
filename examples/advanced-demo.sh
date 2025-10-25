#!/usr/bin/env bash

################################################################################
# Advanced Demo Example
# 
# This demonstrates advanced usage of demo-magic.sh including:
# - Custom prompts and colors
# - Multiple sections
# - Realistic development workflow
# - Error handling
################################################################################

# Include demo-magic
. ./src/demo-magic.sh

# Advanced configuration
TYPE_SPEED=60
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W ${COLOR_RESET}"
DEMO_CMD_COLOR=$YELLOW

# Clear screen
clear

# Demo header
echo "🚀 Advanced Demo Magic Example"
echo "=============================="
echo ""
echo "Demonstrating a complete development workflow"
echo ""
sleep 3

# Section 1: Environment Setup
echo "📋 Section 1: Environment Check"
echo "-------------------------------"
sleep 1

pe "node --version"
pe "npm --version"
pe "git --version"

echo ""
echo "✅ Environment looks good!"
sleep 2

# Section 2: Project Setup  
echo ""
echo "📦 Section 2: Project Setup"
echo "---------------------------"
sleep 1

pe "mkdir demo-project && cd demo-project"
pe "npm init -y"

# Show package.json was created
pei "ls -la"

echo ""
echo "📝 Let's examine the package.json:"
pe "head -10 package.json"

sleep 2

# Section 3: Dependencies
echo ""
echo "🔧 Section 3: Installing Dependencies"
echo "------------------------------------"
sleep 1

# Simulate installing dependencies (don't actually do it for demo speed)
p "npm install express cors dotenv"
echo ""
echo "Installing dependencies... (simulated for demo)"
sleep 2
echo "✅ Dependencies installed!"

# Create a fake node_modules for demo
mkdir -p node_modules
echo '{"name": "express", "version": "4.18.2"}' > node_modules/package.json

pe "ls -la"

sleep 2

# Section 4: Code Creation
echo ""
echo "💻 Section 4: Writing Code"
echo "-------------------------"
sleep 1

pe "touch server.js"

# Show we're "editing" a file
p "vim server.js"
echo ""
echo "Creating server.js... (simulated)"
sleep 1

# Create actual file for demo
cat > server.js << 'EOF'
const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
    res.json({ message: 'Hello from Express!' });
});

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
EOF

pe "head -15 server.js"

sleep 2

# Section 5: Testing
echo ""
echo "🧪 Section 5: Testing the Application" 
echo "------------------------------------"
sleep 1

# Simulate starting server
p "npm start"
echo ""
echo "Starting server... (simulated)"
sleep 1
echo "Server started on http://localhost:3000"

# Test with curl (simulate)
p "curl http://localhost:3000"
echo '{"message": "Hello from Express!"}'

sleep 2

# Section 6: Version Control
echo ""
echo "📚 Section 6: Version Control"
echo "----------------------------"
sleep 1

pe "git init"
pe "git add ."
pe "git status"

# Commit
pe "git commit -m 'Initial commit: Express server setup'"

echo ""
echo "📈 Let's see our git log:"
pe "git log --oneline"

sleep 2

# Section 7: Cleanup and Summary
echo ""
echo "🧹 Section 7: Cleanup"
echo "--------------------"
sleep 1

pe "cd .."
pe "rm -rf demo-project"

echo ""
echo "✨ Demo Complete!"
echo "================"
echo ""
echo "This demo showed:"
echo "  ✅ Environment validation"
echo "  ✅ Project initialization"  
echo "  ✅ Dependency management"
echo "  ✅ Code development"
echo "  ✅ Application testing"
echo "  ✅ Version control workflow"
echo ""
echo "Thanks for watching! 🎬"

sleep 3