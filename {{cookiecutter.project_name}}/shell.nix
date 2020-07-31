{ sources ? import ./nix/sources.nix, pkgs ? import sources.nixpkgs {} }:

pkgs.mkShell {
  packages = [
    pkgs.python{{ cookiecutter.__python_version }}
    pkgs.poetry
    pkgs.just
    pkgs.git
    pkgs.niv
  ];

  shellHook = ''
    export LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib/:$LD_LIBRARY_PATH"
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath packages}:$LD_LIBRARY_PATH"
    if [ -f ".venv/bin/python" ]; then
        . .venv/bin/activate
    fi
  '';
}
