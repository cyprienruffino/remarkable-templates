#!/bin/sh
# Shows custom templates alongside xochitl's own, without writing to the
# read-only system partition: a copy of /usr/share/remarkable/templates, plus
# the templates in templates/ and their index entries from entries.json, is
# bind-mounted over it. Run by xovi before xochitl starts (pre-start), so new
# built-in templates from OS updates are picked up too; with "stop", undoes it
# (pre-stock).
set -e

base=/home/root/.local/share/custom-templates
system=/usr/share/remarkable/templates
merged="$base/merged"

# Back to the real folder, in case it's still mounted from a previous run
while mountpoint -q "$system"; do
    umount "$system"
done
[ "$1" = stop ] && exit 0

rm -rf "$merged"
mkdir -p "$merged"
cp -a "$system"/. "$merged"/
cp "$base"/templates/*.template "$merged"/
# Our entries go first in the index, right after its opening "templates": [
awk -v entries="$base/entries.json" '
    { print }
    /"templates": *\[/ { while ((getline line < entries) > 0) print line }
' "$system/templates.json" > "$merged/templates.json"

mount --bind "$merged" "$system"
