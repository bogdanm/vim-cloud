vim-cloud
=========

My vim, everywhere.

# Installation

Use the installation script with care. It has not been tested with exotic
configurations. The `.vimrc` file and the `.vim` folder are supposed to be in
the home folder `~/`.

The script tries to be conservative and keep the present custom vim, if any. No
merge is done: If installation goes on, the new `.vimrc` is fully copied,
backing up and removing the old one.

```bash
git clone git@github.com:AlessandroA/vim-cloud.git
cd vim-cloud
chmod +x vim-cloud.sh
./vim-cloud.sh
```

The installation script is mostly needed once. A symbolic link is created in
the home folder that points to the `vimrc` file of this repository, so that
pushed/pulled changes are automatically applied.  The script can be repeatedly
used to update existing builds. Unless a structural change has happened in the
repository, the update is basically equivalent to:
```bash
vim +PluginInstall +qall
```

## WSL-specific

`sudo apt install powerline`.

See also https://devpro.media/install-powerline-windows/

