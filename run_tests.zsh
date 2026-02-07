#!/usr/bin/env zsh

# Get the directory where this script is located
SCRIPT_DIR="${0:A:h}"

# Track overall exit status
OVERALL_EXIT_STATUS=0

# Run parser tests
echo "Running parser tests..."
"$SCRIPT_DIR/tests/test_parsers.zsh"
if [[ $? -ne 0 ]]; then
    OVERALL_EXIT_STATUS=1
fi

echo ""
echo "================================"
echo ""

# Run integration tests
echo "Running integration tests..."
"$SCRIPT_DIR/tests/test_integration.zsh"
if [[ $? -ne 0 ]]; then
    OVERALL_EXIT_STATUS=1
fi

echo ""
echo "================================"
echo ""

if [[ $OVERALL_EXIT_STATUS -eq 0 ]]; then
    echo "All test suites passed! ✓"
else
    echo "Some test suites failed! ✗"
fi

exit $OVERALL_EXIT_STATUS
