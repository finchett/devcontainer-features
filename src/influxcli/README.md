
# InfluxCLI for Development Containers

A feature that installs the latest version of InfluxCLI.

## Example Usage

```json
"features": {
    "ghcr.io/finchett/devcontainer-influxcli/influx-cli": {
        "architecture": "x86_64",
        "version": "2.7.3"
    }
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| architecture | `x86_64` or `arm64`` | string | `x86_64` |
