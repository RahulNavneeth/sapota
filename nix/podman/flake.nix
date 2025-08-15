{
  description = "NIX PODMAN";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        lnx-pkgs = nixpkgs.legacyPackages.aarch64-linux;

        nginx-container = pkgs.dockerTools.buildLayeredImage {
          name = "nginx";
          tag = "latest";
          contents = with lnx-pkgs; [ nginx coreutils zsh ];
          extraCommands = ''
            mkdir -p var/log/nginx
            mkdir -p etc
            echo "root:x:0:0::/root:/bin/sh" > etc/passwd
            echo "nobody:x:65534:65534::/:/bin/false" >> etc/passwd
            echo "root:x:0:" > etc/group
            echo "nogroup:x:65534:" >> etc/group
          '';
          config = {
            Cmd = [ "nginx" "-g" "daemon off;" ];
			ExposedPorts = { "80/tcp" = {}; };
          };
        };
      in {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [ podman gnumake ];
          shellHook = ''
            if ! podman machine inspect >/dev/null 2>&1; then
              podman machine init
            fi
            podman machine start
          '';
        };
        packages = {
          nginx = nginx-container;
        };
      });
}
