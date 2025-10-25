---
name: Bug Report
about: Create a report to help us improve spilltea
title: '[BUG] '
labels: bug
assignees: ''

---

**Describe the bug**
A clear and concise description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. Run command '...'
2. With script '...'
3. See error

**Expected behavior**
A clear and concise description of what you expected to happen.

**Environment (please complete the following information):**
 - OS: [e.g. macOS 13.5, Ubuntu 22.04]
 - Shell: [e.g. bash, zsh]
 - spilltea version: [run `spilltea --version` or `spilltea --help`]
 - Dependencies:
   - asciinema version: [run `asciinema --version`]
   - agg version: [run `agg --version`]
   - pv version: [run `pv --version`]

**Command used**
```bash
# The exact spilltea command that caused the issue
spilltea --script example.sh --output demo
```

**Error output**
```
Paste the full error output here
```

**Demo script (if applicable)**
```bash
#!/bin/bash
# Your demo script content that caused the issue
```

**Additional context**
Add any other context about the problem here. Include:
- Were you able to run the local tests? (`./test-local.sh`)
- Did the installation complete successfully?
- Any custom configuration or environment variables?