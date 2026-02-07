#!/usr/bin/env zsh

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counters
TESTS_PASSED=0
TESTS_FAILED=0
TESTS_TOTAL=0

# Assert equal function
assert_equal() {
    local expected="$1"
    local actual="$2"
    local test_name="$3"
    
    TESTS_TOTAL=$((TESTS_TOTAL + 1))
    
    if [[ "$expected" == "$actual" ]]; then
        echo "${GREEN}✓${NC} $test_name"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        echo "${RED}✗${NC} $test_name"
        echo "  Expected: $expected"
        echo "  Got:      $actual"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

# Assert contains function
assert_contains() {
    local haystack="$1"
    local needle="$2"
    local test_name="$3"
    
    TESTS_TOTAL=$((TESTS_TOTAL + 1))
    
    if [[ "$haystack" == *"$needle"* ]]; then
        echo "${GREEN}✓${NC} $test_name"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        echo "${RED}✗${NC} $test_name"
        echo "  Expected to find: '$needle'"
        echo "  In: '$haystack'"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

# Print summary function
print_summary() {
    echo ""
    echo "================================"
    echo "Test Results:"
    echo "  Total:  $TESTS_TOTAL"
    echo "  ${GREEN}Passed: $TESTS_PASSED${NC}"
    if [[ $TESTS_FAILED -gt 0 ]]; then
        echo "  ${RED}Failed: $TESTS_FAILED${NC}"
        return 1
    else
        echo "  Failed: $TESTS_FAILED"
        return 0
    fi
}
