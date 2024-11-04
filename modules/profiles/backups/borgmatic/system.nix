{ config, profiles, ... }: {
  imports = [ ./common.nix profiles.filesystems.files.backup ];

  services.borgmatic.configurations.system = {
    source_directories = [ "/etc" "/var/lib" "/srv" "/root" ];
    exclude_patterns = [
      "**/.cache"
      "**/.nix-profile"
      "/var/lib/containers"
      "/var/lib/docker"
      "/var/lib/libvirt"
      "/var/lib/postgresql"
      "/var/lib/systemd"
      "/var/logs"
    ];
    repositories = [
      {
        label = "rsync.net";
        path =
          "ssh://de2228@de2228.rsync.net/./${config.networking.hostName}-system";
      }
      {
        label = "omnibus";
        # If backing up omnibus, just back up to the already-present directory
        path = if config.networking.hostName == "omnibus" then
          "/data/files/backup/${config.networking.hostName}-system"
        else
          "/mnt/files/backup/${config.networking.hostName}-system";
      }
    ];
    keep_daily = 7;
    keep_weekly = 4;
    keep_monthly = 3;
  };
}
