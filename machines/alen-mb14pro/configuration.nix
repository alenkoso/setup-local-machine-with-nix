{ config, lib, pkgs, nix-darwin, home-manager, ... }:
let
  username = "ak93"; #change this
in
{
	networking.hostName = "alen-mb14pro"; #change this

	nixpkgs.config.allowBroken = true;

	services.nix-daemon.enable = true;
	security.pam.enableSudoTouchIdAuth = true;

	programs.zsh.enable = true;
	environment.shells = with pkgs; [ zsh ];
	environment.systemPackages = with pkgs; [
		nixfmt
		sops
		gopls
	];

	homebrew = {
		brews = [
			#"qemu"
			# "podman"
		];

		taps = [
			"homebrew/core"
			"homebrew/cask"
			"homebrew/cask-versions"
		];

		casks = [
			#"alacritty"
			# "visual-studio-code"
			"rectangle"
			#"firefox"
			# "slack"
			# "zoom"
			"lastpass"
			"stats"
			"iterm2"
			"gimp"
			"vlc"
			# "google-chrome"
			"darktable"
			"flameshot"
			"pgadmin4"
			# "mysql-workbench"
			"maccy"
		];
	};

	home-manager.users."${username}" = import ./home.nix;
	users.users."${username}" = {
		home = "/Users/${username}";
		shell = pkgs.zsh;
	};
}
