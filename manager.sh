#!/usr/bin/env bash

set -Eeuo pipefail

declare -a \
	to_be_removed

while getopts 'r:' opt; do
	case "$opt" in
		r) to_be_removed+=("$OPTARG") ;;
		*) exit 64 ;;
	esac
done
shift $((OPTIND-1))

declare -r repository="$1"

declare tmpdir
tmpdir="$(mktemp -d)"
readonly tmpdir

cd "$tmpdir"

info() {
	>&2 printf '%s: %s\n' "$(date --utc +%Y-%m-%dT%H:%M:%SZ)" "$*"
}

info "Processing ${repository}"
declare remote='origin'
git clone "$repository" .
if [[ $repository =~ github.com.openshift ]]; then
	info "Setting '${repository/openshift/${remote}}' as the push remote"
	remote='shiftstack'
	git remote add "$remote" "${repository/openshift/${remote}}"
fi

git checkout -b "shiftstack_owners"

for u in "${to_be_removed[@]}"; do
	sed -i "/${u}/d" ./*OWNERS*
done

if [[ $(git status --porcelain) ]]; then
	info 'Pushing the change'
	git add ./*OWNERS*
	git commit -m "NO-JIRA: Update ShiftStack OWNERS"
	git push "$remote" shiftstack_owners --force
else
	info 'No change to make'
fi

rm -rf "$tmpdir"
