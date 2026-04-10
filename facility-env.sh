#!/bin/bash
# Site detection for ask-nersc skill.
# Sets NERSC_DOCS_ROOT with a facility-appropriate default.
# Can always be overridden by setting NERSC_DOCS_ROOT before sourcing.

if [ -d /sdf ]; then
    # S3DF (SLAC)
    export NERSC_DOCS_ROOT="${NERSC_DOCS_ROOT:-/sdf/group/lcls/ds/dm/apps/dev/data/nersc-docs}"
    export PATH="/sdf/group/lcls/ds/dm/apps/dev/bin:$PATH"
fi
