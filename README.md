# Manager

Updates OWNERS and OWNERS_ALIASES files.

Currently, this script can only remove names.

## Usage

For one repository:


```shell
./manager.sh -r github_handle repository
```

then click on the link in the `remote` message to create a pull request.

Works with both HTTPS (`https://github.com/owner/repository.git`) and SSH (`git@github.com:owner/repository.git`) formats.

## Mass Usage

More useful when performed on many repositories.

```shell
for repository in one two three; do
	./manager.sh -r github_handle1 -r github_handle2 git@github.com:owner/${repository}.git 2>&1
done | tee logs.txt | grep 'https://github.com'
```

then click on each link to create a pull request.
