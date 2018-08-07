setenv _CONDA_EXE "/xc.reactive_python2.7/bin/conda"
setenv _CONDA_ROOT "/xc.reactive_python2.7"

# Recommended way to make the conda command available in csh is
#   $ sudo ln -s <CONDA_ROOT>/etc/profile.d/conda.csh /etc/profile.d/conda.csh
# or in ~/.cshrc add the line
#   source <CONDA_ROOT>/etc/profile.d/conda.csh

# This block should only be for dev work. Under normal installs, _CONDA_EXE will be templated
# in at the top of this file.
if (! $?_CONDA_EXE) then
  set _CONDA_EXE="${PWD}/conda/shell/bin/conda"
else
  if ("$_CONDA_EXE" == "") then
      set _CONDA_EXE="${PWD}/conda/shell/bin/conda"
  endif
endif

if ("`alias conda`" == "") then
    if ($?_CONDA_ROOT) then
        alias conda source "${_CONDA_ROOT}/etc/profile.d/conda.csh"
    else
        alias conda source "${PWD}/conda/shell/etc/profile.d/conda.csh"
    endif
    setenv CONDA_SHLVL 0
    if (! $?prompt) then
        set prompt=""
    endif
else
    switch ( "${1}" )
        case "activate":
            set ask_conda="`(setenv prompt '${prompt}' ; '${_CONDA_EXE}' shell.csh activate '${2}' ${argv[3-]})`" || exit ${status}
            eval "${ask_conda}"
            rehash
            breaksw
        case "deactivate":
            set ask_conda="`(setenv prompt '${prompt}' ; '${_CONDA_EXE}' shell.csh deactivate '${2}' ${argv[3-]})`" || exit ${status}
            eval "${ask_conda}"
            rehash
            breaksw
        case "install" | "update" | "uninstall" | "remove":
            $_CONDA_EXE $argv[1-]
            set ask_conda="`(setenv prompt '${prompt}' ; '${_CONDA_EXE}' shell.csh reactivate)`" || exit ${status}
            eval "${ask_conda}"
            rehash
            breaksw
        default:
            $_CONDA_EXE $argv[1-]
            breaksw
    endsw
endif
