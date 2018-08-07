# Bashenv Kickstarter Repo

Provides on any architecture compliant system a way to get to

- python
- git
- hg


through static access to a snapshot of this repo (e.g. via http, scp) only.

Especially useful in container bare host OSes or airtight networks w/o package
server access.

Remember that repo servers like github usually provide static snapshots as well,
i.e. you can directly use those to get to an init env for cloning, e.g. `bashenv`.


# Usage Example

Before cloning anything anywhere you can do in an installer:

```bash
#!/usr/bin/env bash

set -eu

ks_prefix="/opt/.bashenv_init_conda"
ks_url="https://github.com/axiros/bashenv_kickstart/archive/master.zip"


get_hg () {
    echo "Downloading init conda"

    # GH's zip format cannot be piped, bad (for tar this would be a one liner)
    local wd="/tmp/workdir.$$"
    /bin/rm -rf "$wd"
    mkdir -p "$wd"
    wget -q "$ks_url" -O "$wd/d.zip"
    unzip -qo "$wd/d.zip" -d "$wd"
    # we don't want to rely on the name of the unzipped directory:
    /bin/mv "$wd/`/bin/ls $wd/ | grep -v '.zip'`" "$ks_prefix"
    /bin/rm -rf "$wd"
}

activate_hg () {
    test -e "$ks_prefix/bin/hg" || get_hg
    echo "Activating init conda at $ks_prefix"
    export PATH="$ks_prefix/bin:$PATH"
    type hg && echo "(have hg)"
}

type hg || activate_hg
```
----

This repo (incl. this README) is created by `bashenv` itself, build script there, in
`misc/create_bashenv_kickstart`.


