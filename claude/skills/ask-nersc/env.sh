#!/bin/bash
# Environment for ask-nersc skill.
# Site-specific config goes in env.local (not tracked in git).
SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
if [[ -f "$SKILL_DIR/env.local" ]]; then
    source "$SKILL_DIR/env.local"
fi
export NERSC_DOCS_ROOT="${NERSC_DOCS_ROOT:-}"
