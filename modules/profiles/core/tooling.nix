{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    btop
    bind
    comma
    glances
    inetutils
    iperf3
    lm_sensors
    tmux
    vim
  ];

  programs.htop.enable = true;
  programs.mtr.enable = true;
}
