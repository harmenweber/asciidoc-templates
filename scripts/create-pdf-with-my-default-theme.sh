#!/usr/bin/env bash

# Exit on error. Append "|| true" if you expect an error.
set -o errexit
# Exit on error inside any functions or subshells.
set -o errtrace
# Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
set -o nounset
# Catch the error in case mysqldump fails (but gzip succeeds) in `mysqldump |gzip`
set -o pipefail
# Turn on traces, useful while debugging but commented out by default
# set -o xtrace

# Collect information about the running script.
readonly scriptFile="$(basename "${0}")"
readonly scriptName="$(basename "${0}" .sh)"
readonly scriptHome="$(cd $(dirname "${0}") && pwd)"

# Constants
readonly themesHome="${scriptHome}/../themes"
readonly fontsHome="${scriptHome}/../fonts"
readonly fontsListSeparatedBySemicolon="$(find "${fontsHome}" -depth 1 | tr '\n' \;)"

asciidoctor-pdf \
    -a pdf-theme="${themesHome}/my-default-theme.yml" \
    -a pdf-fontsdir="${fontsListSeparatedBySemicolon};GEM_FONTS_DIR" \
    "$@"