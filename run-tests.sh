#!/bin/bash

# Exit on any error
set -e

echo "🚀 Starting MeTTa Tests..."

# Find all .metta files in test directories
# Matches files ending in -test.metta or starting with test-
TEST_FILES=$(find . -path "*/test/*.metta" -o -name "*-test.metta")

if [ -z "$TEST_FILES" ]; then
    echo "⚠️ No test files found matching the pattern."
    exit 0
fi

FAILED=0
COUNT=0

for file in $TEST_FILES; do
    echo "------------------------------------------------"
    echo "Running test: $file"
    # Execute metta and check exit code
    if metta "$file"; then
        echo "✅ Passed: $file"
    else
        echo "❌ Failed: $file"
        FAILED=1
    fi
    COUNT=$((COUNT+1))
done

echo "------------------------------------------------"
if [ $FAILED -ne 0 ]; then
    echo "❌ Some tests failed! (Total: $COUNT)"
    exit 1
fi

echo "✨ All $COUNT tests passed successfully!"
