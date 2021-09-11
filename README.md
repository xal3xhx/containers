# Container Images Mirror

Images are hosted on Github Container Registry [here](https://github.com/orgs/truecharts/packages?ecosystem=container&visibility=public).


### Mirror

We host a dedicated mirror repostiory, these containers are direct copies from official trusted sources.

## Purpose

This is to get around Docker Hub rate-limiting (100 pulls / 6 hours, or authenticated 200 pulls / 6 hours). It is considered a stop-gap until the maintainers of the applications below support a different Container Registry.

## Supported images

When upstream maintainers add support for an additional registry, the images here will be purged after we replaced the images in our Charts.

| Name                                                                                            | Upstream Issue                                                                                                                                                                                     |
|-------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [code-server](https://github.com/cdr/code-server)                                               | [![GitHub issue status](https://img.shields.io/github/issues/detail/state/cdr/code-server/3335)](https://github.com/cdr/code-server/issues/3335)                                                   |
| [jellyfin](https://github.com/jellyfin/jellyfin)                                                | [![GitHub issue status](https://img.shields.io/github/issues/detail/state/jellyfin/jellyfin/6024)](https://github.com/jellyfin/jellyfin/issues/6024)                                               |
| [node-red](https://github.com/node-red/node-red)                                                | [![GitHub issue status](https://img.shields.io/github/issues/detail/state/node-red/node-red/3107)](https://github.com/node-red/node-red/issues/3107)                                               |
| [eclipse-mosquitto](https://github.com/eclipse/mosquitto)                                       | [![GitHub issue status](https://img.shields.io/github/issues/detail/state/eclipse/mosquitto/2279)](https://github.com/eclipse/mosquitto/issues/2279)                                               |


## Contributing

You can discover containers running in your cluster from Docker Hub by using the following command:

```
kubectl get pods --all-namespaces -o=jsonpath="{range .items[*]}{'\n'}{range .spec.containers[*]}{.image}{'\n'}{end}{end}" | sort | uniq | grep -Ev 'quay|gcr|ghcr|ecr' |  sed -e 's/docker\.io\///g' | sort | uniq
```

After you have determined some image you want to mirror, do the following:

- If not already created, create an issue upstream asking for them to support an additional registry.
- Open a PR adding a new application to the `mirror` folder, update the `README.md` with the issue link, and then update `.github/renovate.json5` to auto merge it.
- Remind us to make the image public after the PR is merged ;)
