#!/bin/sh
# Installs the custom templates on the tablet, over ssh (host "remarkable", or RM_HOST).
#   ./install.sh
# Then restart xochitl (or the tablet, then /home/root/xovi/start).
set -e
cd "$(dirname "$0")"
host="${RM_HOST:-remarkable}"
base=/home/root/.local/share/custom-templates

ssh "$host" "mkdir -p $base/templates"
scp -q templates/*.template "$host:$base/templates/"
scp -q entries.json custom-templates.sh "$host:$base/"
ssh "$host" "chmod +x $base/custom-templates.sh
    ln -sf $base/custom-templates.sh /home/root/xovi/scripts/pre-start/custom-templates.sh
    printf '#!/bin/sh\nexec $base/custom-templates.sh stop\n' > /home/root/xovi/scripts/pre-stock/custom-templates.sh
    chmod +x /home/root/xovi/scripts/pre-stock/custom-templates.sh
    $base/custom-templates.sh"
echo "Installed; restart xochitl to see the templates"
