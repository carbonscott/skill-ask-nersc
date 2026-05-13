# skill-ask-nersc

NERSC documentation assistant — a knowledge-wrapper skill that searches a locally-mirrored copy of the NERSC user documentation via an FTS5 index built by `docs-index`.

This repository is **externalized** and centrally deployed via the
[deploy-opencode](https://github.com/carbonscott/deploy-opencode) meta-deploy
(see `skills.manifest.json` and `deploy.sh`).

## Layout

```
.
├── README.md
├── claude/
│   └── skills/
│       └── ask-nersc/
│           ├── SKILL.md
│           ├── bin/                  # docs-index helper (script + python)
│           ├── env.local             # S3DF facility config (NERSC_DOCS_ROOT)
│           ├── env.sh                # generic env loader (sources env.local)
│           └── setup.sh              # one-time skill setup helper
├── opencode/
│   └── skills/
│       └── ask-nersc/                # byte-identical duplicate of claude/skills/ask-nersc/
└── tools/
    └── nersc-docs/
        ├── env.sh                    # tool env (NERSC_DOCS_APP_DIR, NERSC_DOCS_DATA_DIR)
        └── scripts/
            └── nersc-docs-cron.sh    # weekly git pull + reindex
```

`claude/` and `opencode/` are byte-identical — Claude Code reads from `claude/skills/`
while opencode reads from `opencode/skills/`. The duplicate avoids any cross-runtime
shared/ indirection.

## Deploy targets

`deploy-opencode/deploy.sh ask-nersc` rsyncs:

| Source in this repo                | Destination on S3DF                                          |
|------------------------------------|--------------------------------------------------------------|
| `opencode/skills/ask-nersc/`       | `/sdf/group/lcls/ds/dm/apps/dev/opencode/skills/ask-nersc/`  |
| `tools/nersc-docs/`                | `/sdf/group/lcls/ds/dm/apps/dev/tools/nersc-docs/`           |

A symlink `opencode/agents/ask-nersc -> ../skills/ask-nersc` is created on first deploy.

## Cron schedule

The NERSC docs mirror is refreshed weekly. Crontab line installed manually
on `sdfcron001` (deploy.sh does **not** install crontab):

```
0 3 * * 0  /sdf/group/lcls/ds/dm/apps/dev/tools/nersc-docs/scripts/nersc-docs-cron.sh run >> /sdf/group/lcls/ds/dm/apps/dev/data/nersc-docs/cron.log 2>&1
```

Or use the helper:

```
nersc-docs-cron.sh enable    # install crontab entry
nersc-docs-cron.sh disable   # remove crontab entry
nersc-docs-cron.sh status    # show enabled state + recent log
```

The cron job: `git pull` the NERSC docs mirror, rebuild the FTS5 index with
`docs-index`, then `chgrp -R ps-data` for group-read access.

## Data dependency

Documentation data lives at `/sdf/group/lcls/ds/dm/apps/dev/data/nersc-docs/`
(out-of-band; managed by the cron job above, not by `deploy.sh`).

## License

Mirrors the deploy-opencode project license.
