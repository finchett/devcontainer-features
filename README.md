# devcontainer features
This repository is for features I have written for vscode development containers. It currently only contains one feature.

---

**Influx Cli**

A feature for Microsoft development containers that installs the [Influx CLI](https://github.com/influxdata/influx-cli) from their Github release page.
See [src/influxcli/README.md](https://github.com/finchett/devcontainer-influxCLI/tree/main/src/influxcli#readme) for information on usage and options. 

```json
"features": {
    "ghcr.io/finchett/devcontainer-features/influxcli:1": {}
}
```

