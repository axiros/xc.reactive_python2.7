# Creates The Kickstarter Repo

This
- downloads Miniconda 2.7 (if not present already)
- adds packages (e.g. git and hg)
- then activates conda
- and adds packages ($packages).

When we commit and push this to a repo server we have (through its snapshot download
feature) a way to get to git and mercurial on any amd64 system, plus can provide
that on any static webserver in an airtight environ w/o package server access.

