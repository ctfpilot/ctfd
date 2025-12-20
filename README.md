# CTF Pilot's CTFd configuration

This repository contains CTF Pilot's configuration files for [CTFd](https://ctfd.io).  
This includes deployment configurations, plugins and other customizations, customized to be used within the CTF Pilot ecosystem.

## CTFd Version

This configuration currently runs on CTFd version `3.7.7`.

## Git submodules

This repository uses Git submodules to include CTFd plugins and themes.  
After cloning the repository, run the following command to initialize and update all submodules:

```bash
git submodule update --init --recursive
```

## Guides

### How to add new CTFd plugins

1. Create a new directory for your plugin in the `plugins` directory.
2. If the plugin is a Github repo, add it as a submodule:
   ```bash
   git submodule add <repository-url> plugins/<plugin-name>
   ```
3. If the plugin is not a Github repo, copy the plugin files into the new directory.
4. Add the plugin to the `plugins/__init__.py` file:
   ```python
   from .<plugin-name> import <PluginClass>
   ```

The Dockerfile will automatically copy all plugins from the `plugins` directory into the Docker image.

### How to add a new CTFd theme

If the theme is a Github repo, add it as a submodule:

```bash
git submodule add <repository-url> themes/<plugin-name>
```

If the theme is not a Github repo, copy the theme files into the `themes` directory, such that is structured like `themes/<theme-name>/...`.

## Contributing

We welcome contributions of all kinds, from **code** and **documentation** to **bug reports** and **feedback**!

Please check the [Contribution Guidelines (`CONTRIBUTING.md`)](/CONTRIBUTING.md) for detailed guidelines on how to contribute.

To maintain the ability to distribute contributions across all our licensing models, **all code contributions require signing a Contributor License Agreement (CLA)**.
You can review **[the CLA here](https://github.com/ctfpilot/cla)**. CLA signing happens automatically when you create your first pull request.  
To administrate the CLA signing process, we are using **[CLA assistant lite](https://github.com/marketplace/actions/cla-assistant-lite)**.

*A copy of the CLA document is also included in this repository as [`CLA.md`](CLA.md).*  
*Signatures are stored in the [`cla` repository](https://github.com/ctfpilot/cla).*

## License

This repository is licensed under the **EUPL-1.2 License**.  
You can find the full license in the **[LICENSE](LICENSE)** file.

We encourage all modifications and contributions to be shared back with the community, for example through pull requests to this repository.  
We also encourage all derivative works to be publicly available under the **EUPL-1.2 License**.  
At all times must the license terms be followed.

For information regarding how to contribute, see the [contributing](#contributing) section above.

CTF Pilot is owned and maintained by **[The0Mikkel](https://github.com/The0mikkel)**.  
Required Notice: Copyright Mikkel Albrechtsen (<https://themikkel.dk>)

## Code of Conduct

We expect all contributors to adhere to our [Code of Conduct](/CODE_OF_CONDUCT.md) to ensure a welcoming and inclusive environment for all.
