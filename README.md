# nix-dotfiles 

Over-engineered [Nix](https://nixos.org)-powered system configuration and dotfiles for Darwin using [nix-darwin](https://github.com/LnL7/nix-darwin) and [home-manager](https://github.com/nix-community/home-manager).

Current configuration allows you to setup a Macbook, running on Darwin architecture.
## Usage

1. Install Nix & Homebrew
    ```bash
    sh <(curl -L https://nixos.org/nix/install) --daemon
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```
2. Launch `nix-shell` with nixUnstable
    ```bash
    nix-shell -p nixUnstable
    ```
3. Build and switch
    ```zsh
    nix build --extra-experimental-features nix-command --extra-experimental-features flakes .#darwinConfigurations.alen-mb14pro.system 

    # ./result/sw/bin/darwin-rebuild switch --impure --flake .#alen-mb14pro
    # after nixpkgs 22.11, we can remove flag --impure, and use a pure flake
    ./result/sw/bin/darwin-rebuild switch --flake .#alen-mb14pro
    ```
## Credits

Configurations and general structure were heavily inspired by:
- [shaunsingh/nix-darwin-dotfiles](https://github.com/shaunsingh/nix-darwin-dotfiles)
- [yurrriq/dotfiles](https://github.com/yurrriq/dotfiles)
- [lucperkins/nix-home-config](https://github.com/lucperkins/nix-home-config)

## Worth checking out

- https://search.nixos.org/packages
