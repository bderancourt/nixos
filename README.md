# nixos
NixOS configurations

## How to use

<https://nixos-and-flakes.thiscute.world/nixos-with-flakes/other-useful-tips#managing-the-configuration-with-git>  
After a fresh install, in a terminal connected as `benoit`:

```
cd ~
git clone git@github.com:bderancourt/nixos.git
sudo rm -rf /etc/nixos
sudo ln -s ~/nixos/ /etc/nixos

```

To apply the configuration :

```
sudo nixos-rebuild switch
```
