{ pkgs, ... }:
let
	shellAliases = {
		grep = "grep --color=auto";

		ls = "ls -hF --color=tty";
		ll = "ls -l";
		la = "ls -la";
		lr = "ls -lhart";
		#cat = "bat";
		
		# Tools
		k = "kubectl";
		ctx = "kubectx";
		ns = "kubens";
		tf = "terraform";
		tg = "terragrunt";

		# zsh reload
		szsh = "source ~/.zshrc";

		# Nix garbage collection
		garbage = "nix-collect-garbage -d";
	};
in
{
	programs.zsh = {
		inherit shellAliases;

		enable = true;
		enableAutosuggestions = true;
		enableSyntaxHighlighting = true;
		enableCompletion = true;
		
		history.extended = true;

		initExtra = ''
			export TERM="xterm-256color"
			bindkey -e

			# Add Homebrew packages to PATH
			export PATH=/opt/homebrew/bin:$PATH

			# Autocomplete
			source <(kubectl completion zsh)
			source <(awsprofile completion zsh)
			compdef _awsprofile awsprofile
		'';

		oh-my-zsh = {
			enable = true;
			plugins = [
				"git"
				"terraform"
				"kubectl"
			];
			theme = "agnoster";
		};
	};
}
