{
  pkgs ? import <nixpkgs> { },
}:

(pkgs.buildFHSEnv {
  name = "vivado-fhs-env";

  targetPkgs =
    pkgs: with pkgs; [
      # Core system libraries
      libxcrypt-legacy
      stdenv.cc.cc
      stdenv.cc.cc.lib
      glibc
      zlib
      libuuid

      # Use ncurses5 to avoid the tic.pc issue
      ncurses5

      # X11 and graphics (enhanced for Vivado compatibility)
      xorg.libX11
      xorg.libXext
      xorg.libXrender
      xorg.libXtst
      xorg.libXi
      xorg.libXft
      xorg.libxcb
      xorg.libXrandr
      xorg.libXinerama
      xorg.libXcursor
      xorg.libXmu
      xorg.libXpm
      xorg.libXaw
      xorg.libXt
      xorg.libSM
      xorg.libICE
      xorg.libXcomposite
      xorg.libXdamage
      xorg.libXfixes
      xorg.libXv
      xorg.libXvMC

      # OpenGL (enhanced)
      libGL
      libGLU
      mesa
      mesa.drivers

      # Font and graphics (enhanced)
      freetype
      fontconfig
      cairo
      pango
      harfbuzz
      gdk-pixbuf
      atk
      pixman

      # GUI toolkits
      glib
      gtk2
      gtk3
      qt5.qtbase
      qt5.qtx11extras

      # Development tools
      gcc
      binutils

      # System utilities
      bash
      coreutils
      findutils
      gnugrep
      gnused
      gawk
      which
      file
      unzip
      nettools
      procps

      # Additional libraries that Vivado might need
      libpng
      libjpeg
      libtiff
      expat
      dbus
      systemd

      # Java and graphics compatibility
      xorg.xhost
      xorg.xauth
      xorg.xset
      xorg.xdpyinfo
    ];

  multiPkgs =
    pkgs: with pkgs; [
      # 32-bit compatibility libraries if needed
    ];

  runScript = "bash";

  profile = ''
    # Vivado installation path
    export VIVADO_ROOT="/mnt/data/tools/Xilinx/Vivado/2023.2"

    # Add Vivado to PATH
    export PATH="$VIVADO_ROOT/bin:$PATH"

    # Xilinx environment variables
    export XILINX_VIVADO="$VIVADO_ROOT"

    # Library and include paths for FHS compatibility
    export LD_LIBRARY_PATH="/usr/lib:/usr/lib64:/lib:/lib64:$LD_LIBRARY_PATH"
    export LIBRARY_PATH="/usr/lib:/usr/lib64:/lib:/lib64:$LIBRARY_PATH"
    export C_INCLUDE_PATH="/usr/include:$C_INCLUDE_PATH"
    export CPLUS_INCLUDE_PATH="/usr/include:$CPLUS_INCLUDE_PATH"
    export CMAKE_LIBRARY_PATH="/usr/lib:/usr/lib64:$CMAKE_LIBRARY_PATH"
    export CMAKE_INCLUDE_PATH="/usr/include:$CMAKE_INCLUDE_PATH"

    # Force X11 mode for Java applications (fix for Wayland white screen issue)
    export GDK_BACKEND=x11
    export QT_QPA_PLATFORM=xcb
    export DISPLAY=''${DISPLAY:-:0}

    # Java graphics fixes for Wayland/XWayland
    export _JAVA_AWT_WM_NONREPARENTING=1
    export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dsun.java2d.xrender=true"
    export JAVA_TOOL_OPTIONS="-Dswing.systemlaf=true"

    # Mesa/OpenGL settings
    export MESA_GL_VERSION_OVERRIDE=3.3
    export MESA_GLSL_VERSION_OVERRIDE=330

    # Disable Wayland for this session
    unset WAYLAND_DISPLAY

    # Locale settings
    export LANG="en_US.UTF-8"
    export LC_ALL="en_US.UTF-8"

    # Disable some Vivado telemetry/analytics that might cause issues
    export XILINX_LOCAL_USER_DATA="no"

    # echo "==================================="
    # echo "Vivado FHS Environment Loaded"
    # echo "==================================="
    # echo "Vivado Root: $VIVADO_ROOT"
    # echo "Run 'vivado' to start Vivado"
    # echo "Run 'exit' to leave this environment"
    # echo "==================================="

    vivado
  '';
}).env
