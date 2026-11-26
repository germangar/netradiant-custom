# Gamepack overlays

`install-gamepacks.sh` applies this directory after installing the stock gamepacks.

- A `*.game` directory here replaces the corresponding installed gamepack completely.
- Files under `games/` replace the matching game descriptors in `gamepacks/games/`.

This lets the repository keep authoritative customizations without editing downloaded or generated pack contents. The Warfork overlay intentionally contains `entities.ent` and no legacy `entities.def`.
