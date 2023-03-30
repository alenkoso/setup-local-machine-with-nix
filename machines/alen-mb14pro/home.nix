{ pkgs, ... }:
{
	home.stateVersion = "21.11";

	imports = [
		../../configs/direnv.nix
		../../configs/fzf.nix
		../../configs/git.nix
		../../configs/zsh.nix
		../../configs/starship.nix
	];

	home.packages = with pkgs; [
		# Kubernetes
		kubectl
		kubectx
		kubelogin
		gomplate
		kustomize
		kubernetes-helm
		helmfile
		cmctl
		# AWS
		awscli2
		#python3Packages.ec2instanceconnectcli
		python39Packages.ec2instanceconnectcli
		ssm-session-manager-plugin
		# Terraform
		terraform
		terragrunt
		# Sportradar
		srpkgs.awsprofile
		srpkgs.smgo
		# Tools
		yq
		jq
		vault
		renderizer
        pssh
		cowsay
		python39
	];

	accounts.email.accounts.primary = {
		address = "email@address.com"; #change this
		primary = true;
		realName = "Alen K"; #change this
	};

	programs.go.enable = true;

	programs.ssh = {
		enable = true;
		controlPath = "none";
		extraConfig = ''
			# SSH over Session Manager
			host i-* mi-*
				ProxyCommand sh -c "aws ssm start-session --target %h --document-name AWS-StartSSHSession --parameters 'portNumber=%p'"
		'';
	};
}
