Thank for https://oliverkovacs.dev/blog/2025/05/02/installing-vivado-on-nixos.html

## Tested list
- Vivado 2023.2

## Install
- nix-shell

- enter Vivado Single-File Download Path

- ./xsetup -b ConfigGen

- consider change the install path which by modify `Destination`

- $EDITOR ~/.Xilinx/install_config.txt

- ./xsetup -a XilinxEULA,3rdPartyEULA -b Install -c $HOME/.Xilinx/install_config.txt

- copy `vivado_shell.nix` as `shell.nix` in your install path

- enter install path and run `nix-shell`

## Desktop Entry
- $EDITOR ~.local/share/applications/Vivado<user install version>.Desktop
- Modify `Exec=nix-shell <your install path>/Xilinx/shell.nix`

## udev
TODO, see https://blog.kotatsu.dev/posts/2021-09-14-vivado-on-nixos/
