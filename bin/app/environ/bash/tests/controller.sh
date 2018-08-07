#!/usr/bin/env bash

set -eu

here="$(unset CDPATH && cd "$(dirname "$BASH_SOURCE")/.." && echo $PWD)"

# prefixes we'll be creating:
P1="/tmp/xc"
P2="/tmp/xc2"
P3="/tmp/xc3"

# the installer script:
create_rel="misc/create_bashenv/create"
create="$here/$create_rel"

# constructor created installers will land here:
d_inst="/tmp/installers"
# created at second test:
base_installer=

export be_force_colors=true
syspath="$PATH"

# Example config with additional tools.
# does contain tests and python_tests:
test_config1="$here/misc/be_configs/reactive_python2.7"


# ----------------------------------------------------------------------- Tools
run () {
    echo
    echo '*******************************************'
    echo TEST: "$1"
    echo '*******************************************'
    echo
    $1
}

act_verify () {
    # verify the basic working of a new bashenv:
    export PATH="$syspath"
    local prefix="${1:-xx}"
    source "$prefix/bin/activate"
    conda info -a
    which python      | grep "$prefix" || exit 1
    which pip         | grep "$prefix" || exit 1
    which hg          | grep "$prefix" || exit 1
    which git         | grep "$prefix" || exit 1
    which constructor | grep "$prefix" || exit 1
    test -e "$prefix/.git" || exit 1
    # only this allows to remove directly after git -A:
    # otherwise the gc process conflicts with rm:
    # can't do, tests are also on non travis:
    # looping in del instead... :-/
    #git config --global gc.auto 0
}

del () {
    # because of git's stupid gc which I can't turn off w/o git...
    for i in 1 2 3 4 5; do
        echo "trying delete $1..."
        /bin/rm -rf "$1" && return 0
        echo "could not delete... trying again in 2"
        sleep 2
    done
    exit 1
}

# ----------------------------------------------------------------------- Tests
test_create_scratch () {
    echo "Creating a bashenv from scratch, with only wget available."
    echo "(that requires internet to pull conda stuff)"
    del "$P1"
    $create -p "$P1" go
    # now we have git and hg and pip:
    act_verify "$P1"
}

test_construct_relocatable_conda_installer_with_packages () {
    echo "we create a single file installer for offline installs"
    del "$d_inst"
    act_verify "$P1"
    mkdir -p "$d_inst"
    constructor --output-dir="$d_inst" "$here/misc/constructions/base"
    echo "constructed: `ls -lta $d_inst`"
}

test_bootstrap_from_constructed () {
    echo "From the single file installer we can create a full bashenv - "
    echo "(at an arbitrary location)"
    del "$P2"
    base_installer="$d_inst/`/bin/ls $d_inst | grep base_`"

    "$create" -b -C "$base_installer" -p "$P2" go

    act_verify "$P2"

    # reusing this one, for future installs:
    echo "copying base installer to cache"

    source "$create" # read the installer package cache variable
    cp "$base_installer" "$cached_installer"
}


test_create_from_existing_with_packages () {
    echo "From the single file installer we now create a richer environment:"
    cat "$test_config1"
    echo "(Note that the config file contains also a few basic tests for those new tools)"
    del "$P3"
    source "$P1/bin/activate"
    nfo "have it"
    "$P1/bin/app/environ/bash/$create_rel" -b -p "$P3" -c "$test_config1" go
    act_verify "$P3"
}



main () {
    ( run test_create_scratch                                      )
    ( run test_construct_relocatable_conda_installer_with_packages )
    ( run test_bootstrap_from_constructed                          )
    ( run test_create_from_existing_with_packages                  )
}

main $*
