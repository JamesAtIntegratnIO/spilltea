# Demo Magic Automation Examples

This directory contains example demo scripts showing different use cases and complexity levels.

## 📋 Available Examples

### 1. Basic Demo (`basic-demo.sh`)
**Purpose**: Introduction to demo-magic.sh functions  
**Duration**: ~30 seconds  
**Complexity**: Beginner  

Demonstrates:
- `pe` (print and execute)
- `pei` (print and execute immediately) 
- `p` (print only)
- Basic wait functionality

**Usage**:
```bash
# Run interactively
./examples/basic-demo.sh

# Generate GIF
make basic
# or
./record-demo --script examples/basic-demo.sh --title "Basic Demo"
```

### 2. Advanced Demo (`advanced-demo.sh`)
**Purpose**: Complete development workflow simulation  
**Duration**: ~2-3 minutes  
**Complexity**: Advanced  

Demonstrates:
- Multi-section presentation structure
- Realistic development workflow
- File creation and manipulation
- Git operations
- Custom prompts and colors
- Behind-the-scenes operations

**Usage**:
```bash
# Run interactively
./examples/advanced-demo.sh

# Generate GIF
make advanced
# or
./record-demo --script examples/advanced-demo.sh --title "Advanced Workflow"
```

## 🎨 Customization Examples

### Quick Social Media Demo
```bash
./record-demo \
  --script examples/basic-demo.sh \
  --font-size 16 \
  --cols 80 \
  --rows 20 \
  --speed 2.5 \
  --theme dracula \
  --gif-file social-demo.gif
```

### Presentation Demo
```bash
./record-demo \
  --script examples/advanced-demo.sh \
  --font-size 18 \
  --cols 100 \
  --rows 25 \
  --speed 1.2 \
  --theme github-dark \
  --gif-file presentation-demo.gif
```

### Documentation Demo
```bash
./record-demo \
  --script examples/basic-demo.sh \
  --font-size 12 \
  --cols 120 \
  --rows 35 \
  --speed 1.8 \
  --theme solarized-light \
  --gif-file docs-demo.gif
```

## 🔧 Creating Your Own Demo

### 1. Basic Template
```bash
#!/usr/bin/env bash

# Include demo-magic
. ./src/demo-magic.sh

# Configuration
TYPE_SPEED=40
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W ${COLOR_RESET}"

# Clear screen
clear

# Your demo content here
pe "echo 'Your first command'"
pei "ls -la"
p "echo 'This is just printed'"

# End demo
echo "Demo complete!"
```

### 2. Structured Template
```bash
#!/usr/bin/env bash

. ./src/demo-magic.sh

TYPE_SPEED=50
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W ${COLOR_RESET}"

clear

# Section 1
echo "📋 Section 1: Setup"
echo "------------------"
sleep 2
pe "command1"
pe "command2"

# Section 2  
echo ""
echo "🚀 Section 2: Action"
echo "-------------------"
sleep 2
pei "command3"
pei "command4"

# Conclusion
echo ""
echo "✨ Complete!"
```

### 3. Interactive Template
```bash
#!/usr/bin/env bash

. ./src/demo-magic.sh

TYPE_SPEED=40

clear

echo "🎬 Interactive Demo"
echo "=================="
echo "Press ENTER to continue through each step..."
echo ""

wait

pe "step1"
wait

pe "step2"
wait

echo "Thanks for watching!"
```

## 🎯 Best Practices

### Timing and Pacing
- Use `sleep` between sections for better flow
- Keep individual commands under 10 seconds
- Use `pei` for quick, non-critical commands
- Use `pe` for important commands you want to emphasize

### Visual Design
- Start with `clear` for clean slate
- Use section headers with emoji for organization
- Add brief explanations between command groups
- End with a summary or conclusion

### Command Selection
- Choose commands that work reliably across systems
- Avoid commands that require user input (unless using `p`)
- Test commands in clean environment first
- Have fallback commands for different systems

### File Operations
- Create temporary files/directories as needed
- Clean up after yourself (remove temp files)
- Use relative paths when possible
- Test file operations before recording

## 🎪 Demo Ideas

### Development Workflows
- Project setup and initialization
- Package installation and configuration
- Code compilation and testing
- Git workflows and version control
- Docker containerization
- CI/CD pipeline setup

### System Administration  
- Server setup and configuration
- Log analysis and monitoring
- Security scanning and updates
- Backup and restore operations
- Network troubleshooting

### Tool Demonstrations
- CLI tool usage and features
- API testing and integration
- Database operations
- Cloud service deployment
- Monitoring and alerting setup

### Educational Content
- Programming language tutorials
- Framework introductions
- Best practice demonstrations
- Troubleshooting common issues
- Performance optimization techniques