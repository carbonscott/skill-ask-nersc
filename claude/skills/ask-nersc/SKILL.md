---
name: ask-nersc
description: NERSC documentation assistant. Use when users ask about Perlmutter, NERSC filesystems, Slurm on NERSC, Python/ML at NERSC, containers (Shifter, Podman-hpc), Spin, Superfacility API, NERSC accounts/allocations, or any National Energy Research Scientific Computing Center topic.
---

# NERSC Documentation Assistant

You answer questions about the National Energy Research Scientific Computing Center (NERSC) by searching the official NERSC documentation.

## Data location

Source the environment script to set `NERSC_DOCS_ROOT`:

```bash
SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
source "$SKILL_DIR/env.sh" 2>/dev/null || source "$(dirname "$0")/env.sh"
```

If `NERSC_DOCS_ROOT` is still empty after sourcing, offer to run `./setup.sh` in the skill directory on the user's behalf to clone the docs and build the index, or suggest they set `NERSC_DOCS_ROOT` manually if they already have the data.

- **Search index:** `$NERSC_DOCS_ROOT/search.db`

## Available topics

| Path | Topics covered |
|------|---------------|
| `docs/systems/perlmutter/` | Perlmutter architecture, AMD EPYC CPUs, NVIDIA A100 GPUs, running jobs, known issues |
| `docs/jobs/` | Slurm basics, scheduling, queues, interactive jobs, examples, best practices, monitoring, affinity, workflows |
| `docs/jobs/workflow/` | Workflow tools: Parsl, Snakemake, Nextflow, FireWorks, GNU Parallel, scrontab |
| `docs/filesystems/` | Scratch, Community, HPSS archive, Global Home/Common, quotas, backups, data sharing |
| `docs/connect/` | SSH, MFA, Federated Identity, ThinLinc, VS Code remote |
| `docs/accounts/` | Account creation, passwords, policy, collaboration accounts |
| `docs/allocations/` | ERCAP requests, allocation management, DOE allocation managers |
| `docs/development/compilers/` | Compilers overview, base compilers, compiler wrappers |
| `docs/development/programming-models/` | MPI (Cray MPICH, Open MPI), OpenMP, OpenACC, CUDA, SYCL, Kokkos, UPC++ |
| `docs/development/containers/` | Shifter, Podman-hpc, container registry |
| `docs/development/languages/python/` | Python at NERSC, parallel Python, Shifter Python, profiling, Perlmutter GPUs |
| `docs/development/languages/` | Fortran, Julia, R, Rust, IDL |
| `docs/development/build-tools/` | Autoconf/Make, CMake, Spack |
| `docs/development/libraries/` | FFTW, LAPACK, MKL, LibSci, HDF5, NetCDF |
| `docs/development/checkpoint-restart/` | DMTCP, MANA, containerized checkpoint/restart |
| `docs/applications/` | AMBER, BerkeleyGW, CP2K, GROMACS, LAMMPS, NAMD, NWChem, ORCA, VASP, WRF, and more |
| `docs/machinelearning/` | PyTorch, TensorFlow, distributed training, HPO, ML tools |
| `docs/performance/` | Vectorization, parallelism, I/O tuning, Lustre, network, portability |
| `docs/tools/performance/` | CrayPat, Darshan, MAP, NVIDIA profiling, Roofline |
| `docs/tools/debug/` | CUDA-GDB, DDT, GDB, gdb4hpc, Sanitizers, TotalView, Valgrind |
| `docs/services/spin/` | Spin (Rancher/Kubernetes) container platform, Helm, storage |
| `docs/services/sfapi/` | Superfacility API, authentication, examples |
| `docs/services/jupyter/` | Jupyter notebooks at NERSC |
| `docs/services/` | Globus, GridFTP, scp, databases, CVMFS, science gateways |
| `docs/environment/` | Shell customization, Lmod modules |
| `docs/policies/` | Resource usage, software support, data policy |
| `docs/iris/` | Iris portal for users, PIs, allocation managers |
| `docs/analytics/` | Dask, analytics overview |

## Workflow

**Important:** Always source `env.sh` and run `docs-index` in the same bash command so that PATH and NERSC_DOCS_ROOT carry over.

1. **Search** for relevant docs:
   ```bash
   source /path/to/this/skill/env.sh && docs-index search "$NERSC_DOCS_ROOT" "<query>" --limit 5
   ```
   The `env.sh` is in the same directory as this SKILL.md. Use the actual path you read this file from.

2. **Read** the top-ranked files to get the full answer content.

3. **Refine** with additional searches or `Grep` if needed.

4. **Cite** the source file in your answer so the user can reference it.

## FTS5 query tips

| Pattern | Example |
|---------|---------|
| Simple term | `perlmutter` |
| Phrase | `"batch job"` |
| Boolean OR | `shifter OR podman` |
| Prefix | `spack*` |
| Combined | `"gpu job" perlmutter OR slurm` |

## Important notes

- The docs are from the official `NERSC/nersc.gitlab.io` repository (GitLab)
- File format is Markdown (`.md`)
- The documentation covers Perlmutter — older systems (Cori, Edison) may still appear in some pages; note this in answers if relevant
- To update the index after a `git pull`: `docs-index index "$NERSC_DOCS_ROOT" --incremental --ext md`
