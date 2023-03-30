{ config, ... }:
let
	aliases = {
		co = "checkout";
		cob = "checkout -b";
		cm = "commit -m";
		ca = "commit --amend";
		pr = "pull --rebase";
	};
in
{
	programs.git = {
		enable = true;
		inherit aliases;

		ignores = [
			".DS_Store"
			".vscode"          
		];
		delta = {
			enable = true;
			options = {
				line-numbers = true;
			};
		};
		extraConfig = {
			core = {
				editor = "vscode";
				whitespace = "trailing-space";
			};
			init.defaultBranch = "main";
			pull.ff = "only";
			url."git@gitlab.sportradar.ag:" = {
				insteadOf = "https://gitlab.sportradar.ag/";
			};
		};
	} // (
		with config.accounts.email.accounts.primary; {
			userEmail = address;
			userName = realName;
		}
	);
}
