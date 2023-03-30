{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    clock24 = true;

    tmuxp.enable = true;

    plugins = with pkgs; [
      {
          plugin = tmuxPlugins.power-theme;
          extraConfig = "set -g @tmux_power_theme 'moon'";
      }
    ];

    extraConfig = ''
      # Set prefix to Ctrl-Space
      #unbind C-b
      #set -g prefix M-Space
      #bind Space send-prefix

      # Use vi keys
      set -gw mode-keys vi

      # Update window title
      set -g set-titles on		
      set -g set-titles-string '#T - #I:#W'

      # Mouse support
      set -g mouse on
    '';
  };
}
