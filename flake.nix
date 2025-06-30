{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;
    
    devShells.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
      buildInputs = with nixpkgs.legacyPackages.x86_64-linux; [
        python3
        nodejs
        pkg-config
        libgcc
        gnumake # gcc, make, etc.
        
        # X11 libraries
        xorg.libX11
        xorg.libXi
        xorg.libXext
        xorg.libX11.dev
        xorg.libXi.dev
        xorg.libXext.dev
        
        # OpenGL libraries
        libGL
        libGLU
        libGL.dev
        libGLU.dev
        
        # Mesa OpenGL implementation
        mesa
        # mesa.dev
        
        # Additional OpenGL headers
        glib
        glib.dev
        
        # UUID library (needed for canvas and other native modules)
        libuuid
      ];
    };

  };
}
