#!/bin/bash

# This test is executed against the scenario in scenarios.json

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
# The 'check' command comes from the dev-container-features-test-lib.
check influx

# Report results
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults