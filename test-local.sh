#!/bin/bash

# Local test runner to simulate CI pipeline
# Run this script to test spilltea locally before pushing

set -e

echo "🧪 Running local spilltea tests..."
echo "================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

success_count=0
test_count=0

run_test() {
    local test_name="$1"
    local test_command="$2"
    
    echo -e "\n${YELLOW}Testing: $test_name${NC}"
    test_count=$((test_count + 1))
    
    if eval "$test_command"; then
        echo -e "${GREEN}✅ $test_name passed${NC}"
        success_count=$((success_count + 1))
    else
        echo -e "${RED}❌ $test_name failed${NC}"
    fi
}

# Test 1: Check required files exist
run_test "Required files exist" "
    [[ -f 'record-demo' ]] && 
    [[ -f 'install.sh' ]] && 
    [[ -f 'scripts/setup.sh' ]] && 
    [[ -f 'Makefile' ]] && 
    [[ -f 'README.md' ]]
"

# Test 2: Check scripts are executable
run_test "Scripts are executable" "
    [[ -x 'record-demo' ]] && 
    [[ -x 'install.sh' ]] && 
    [[ -x 'scripts/setup.sh' ]]
"

# Test 3: Validate shell scripts with shellcheck (if available)
if command -v shellcheck >/dev/null 2>&1; then
    run_test "Shell script validation" "
        shellcheck record-demo install.sh scripts/setup.sh
    "
else
    echo -e "${YELLOW}⚠️  shellcheck not available, skipping shell script validation${NC}"
fi

# Test 4: Check dependencies
run_test "Check dependencies available" "
    command -v asciinema >/dev/null 2>&1 &&
    command -v pv >/dev/null 2>&1
"

# Test 5: Test installation
run_test "Test installation" "
    echo 'y' | ./install.sh >/dev/null 2>&1
"

# Add spilltea to PATH for subsequent tests
export PATH="$HOME/.local/bin:$PATH"

# Test 6: Test help command  
run_test "Test help command" "
    export PATH=\"\$HOME/.local/bin:\$PATH\" &&
    spilltea --help >/dev/null 2>&1
"

# Test 7: Create and run a simple demo
run_test "Create and run demo" "
    export PATH=\"\$HOME/.local/bin:\$PATH\" &&
    mkdir -p test-output &&
    cat > test-output/test-demo.sh << 'EOF' &&
#!/usr/bin/env bash
# Load demo-magic.sh
. \$(dirname \"\$0\")/../src/demo-magic.sh

# Set to non-interactive mode for CI/CD
NO_WAIT=true
TYPE_SPEED=10

clear

pei \"echo 'Starting spilltea test demo...'\"
pei \"echo 'Using demo-magic.sh for simulated typing'\"
pei \"echo 'This is a proper test!'\"
pei \"echo 'Test completed successfully!'\"
EOF
    chmod +x test-output/test-demo.sh &&
    spilltea --script test-output/test-demo.sh --cols 80 --rows 20 --record-only >/dev/null 2>&1 &&
    [[ -f 'demo.cast' ]]
"

# Test 8: Test GIF generation
run_test "Test GIF generation" "
    export PATH=\"\$HOME/.local/bin:\$PATH\" &&
    spilltea --gif-only --cast-file demo.cast --gif-file demo.gif >/dev/null 2>&1 &&
    [[ -f 'demo.gif' ]] &&
    [[ -s 'demo.gif' ]]
"

# Summary
echo -e "\n🏁 Test Summary"
echo "==============="
echo -e "Tests passed: ${GREEN}$success_count${NC}/$test_count"

if [[ $success_count -eq $test_count ]]; then
    echo -e "${GREEN}🎉 All tests passed! Ready for CI/CD pipeline.${NC}"
    exit 0
else
    echo -e "${RED}❌ Some tests failed. Please fix issues before pushing.${NC}"
    exit 1
fi