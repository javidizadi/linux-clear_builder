#!/bin/bash
commit_hash="caa5df2fb6a817f85c9ec94c5af8d2d253a8fecd"
repo=`printenv REPO`
cd /home/linux-clear_builder
git clone https://aur.archlinux.org/linux-clear.git &&
cd linux-clear
echo "Checkout specified commit..."
git checkout $commit_hash &&
echo "Compiling kernel..."
env MAKEFLAGS="-s -j$(nproc)" _localmodcfg=y _subarch=22 makepkg --skippgpcheck &&
echo "Logining in to GitHub..."
printenv GITHUB_KEY | gh auth login --with-token
version=`git log --format=%B -n 1 $commit_hash | awk -F '-' 'NR==1{print "v"$1}'`
gh release view "$version" --repo "$repo"
tag_exists=$?
if test $tag_exists -eq 0; then
    echo "Tag already exists!"
    echo "Removing previous release..."
    gh release delete "$version" -y --cleanup-tag --repo "$repo"
else
    echo "Tag does not exist!"
fi
echo "Releasing $version binaries into $repo"
gh release create "$version" ./*.pkg.tar.zst --repo "$repo" &&
echo "Released!"
echo "Loging out from Github..."
gh auth logout -h github.com
