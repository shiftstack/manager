#!/usr/bin/env bash

set -Eeuo pipefail

declare -a \
	to_be_removed

while getopts 'r:' opt; do
	case "$opt" in
		r) to_be_removed+=("$OPTARG") ;;
	esac
done
shift $((OPTIND-1))

declare -r repository="$1"

declare tmpdir
tmpdir="$(mktemp -d)"
readonly tmpdir

cd "$tmpdir"

declare remote='origin'
git clone "$repository" .
if [[ $repository =~ github.com.openshift ]]; then
	remote='shiftstack'
	git remote add "$remote" ${repository/openshift/${remote}}
fi

git checkout -b "shiftstack_owners"

for u in ${to_be_removed[@]}; do
	sed -i "/${u}/d" OWNERS{,_ALIASES}
done

git add OWNERS{,_ALIASES}
git commit -m "shiftstack: Update OWNERS"
git push "$remote" shiftstack_owners

rm -rf "$tmpdir"