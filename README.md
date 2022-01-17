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

## Example mass usage

```shell
for repository in bugwatcher ci-configs gazelle shiftstack-ci merge-bot; do
        ./manager.sh -r github_handle git@github.com:shiftstack/${repository}.git 2>&1
done | tee logs.txt | grep 'https://github.com'
```

```shell
for repository in cloud-credential-operator cloud-provider-openstack cluster-api-provider-openstack cluster-cloud-controller-manager-operator cluster-image-registry-operator cluster-network-operator cluster-storage-operator csi-driver-manila-operator csi-driver-nfs installer kuryr-kubernetes machine-api-provider-openstack machine-config-operator openstack-cinder-csi-driver-operator release; do
        ./manager.sh -r github_handle git@github.com:openshift/${repository}.git 2>&1
done | tee logs.txt | grep 'https://github.com'
```
