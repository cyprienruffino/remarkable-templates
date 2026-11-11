# reMarkable templates

Custom notebook templates for the reMarkable Paper Pro Move (OS 3.29), installed with [xovi](https://github.com/asivery/xovi).

## Chord grid

Landscape. A full-width grid of 8 × 4 squares, for chord grids, with a strip at the top for the title and notes.

![Chord grid](screenshots/chord-grid.png)

## Install

Needs ssh access to the tablet (host `remarkable`, or set `RM_HOST`) and xovi.

```sh
./install.sh
```

Then restart xochitl. The templates are under their categories, in the landscape templates for landscape ones.

The system partition is read-only and replaced by OS updates, so nothing is written to it. Instead, [custom-templates.sh](custom-templates.sh) bind-mounts a copy of `/usr/share/remarkable/templates`, with these templates added, over it. xovi runs it before starting xochitl (`xovi/scripts/pre-start`), and undoes it when going back to stock (`pre-stock`). After a reboot, run `/home/root/xovi/start` as usual to get them back.

xochitl caches templates: after changing one, close any notebook and restart xochitl.

## Adding a template

1. Add the `.template` file (xochitl's JSON template format) to [templates/](templates).
2. Add its entry to [entries.json](entries.json), one line per template.
3. Run `./install.sh`.

Landscape templates get `templateWidth` and `templateHeight` in the landscape orientation, so `templateWidth` is the page's long side.
