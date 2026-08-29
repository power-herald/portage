# Power Herald Gentoo overlay

Add this overlay with `eselect-repository`:

```sh
eselect repository add power-herald git https://github.com/power-herald/portage.git
emerge --sync power-herald
```

Install Power Herald:

```sh
emerge --ask --quiet-build app-misc/power-herald
```

The default USE flags install SQLite and systemd support. Before starting the
service, configure `/etc/power-herald/config.yaml` with the bot token and other
required settings.