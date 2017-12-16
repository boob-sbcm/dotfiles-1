 { stdenv, fetchFromGitHub, ncurses, pkgconfig, texinfo, libxml2, gnutls, gettext, autoconf, automake, rust
, AppKit, Carbon, Cocoa, IOKit, OSAKit, Quartz, QuartzCore, WebKit
, ImageCaptureCore, GSS, ImageIO # These may be optional
}:

stdenv.mkDerivation rec {
  name = "remacs-${version}";
  version = "26.0.50";

  src = fetchFromGitHub {
    owner = "Wilfred";
    repo = "remacs";
    rev = "d09122ed6e48c62da9395b7da813f16c7ea84fd7";
    sha256 = "0i9633y9v2ml4z2d8sx5gs655fjmzac9ywq1wspkmrphysvbv9lk";
  };

  enableParallelBuilding = true;

  nativeBuildInputs = [ pkgconfig autoconf automake ];
  buildInputs = [ ncurses libxml2 gnutls texinfo gettext rust ];
  propagatedBuildInputs = [
    rust
    AppKit Carbon Cocoa IOKit OSAKit Quartz QuartzCore WebKit
    ImageCaptureCore GSS ImageIO   # may be optional
  ];

  configureFlags = [
    "LDFLAGS=-L${ncurses.out}/lib"
    "--without-makeinfo"
    "--with-ns"
    "--disable-ns-self-contained"
    "--with-modules"
  ];

  CFLAGS = "-O3 -DMAC_OS_X_VERSION_MAX_ALLOWED=MAC_OS_X_VERSION_10_10 -DMAC_OS_X_VERSION_MIN_REQUIRED=MAC_OS_X_VERSION_10_10";
  LDFLAGS = "-O3 -L${ncurses.out}/lib -L../rust_src/remacs-lib/target/release/";
  RUSTFLAGS="-L${rust.out}/lib/rustlib/x86_64-apple-darwin/lib";

  preConfigure = ''
    ./autogen.sh
  '' + ''
    for makefile_in in $(find . -name Makefile.in -print); do
        substituteInPlace $makefile_in --replace /bin/pwd pwd
    done
  '';

  buildPhase = ''
    HOME=/tmp make clean
    HOME=/tmp make LD=/usr/bin/cc CC=/usr/bin/cc RUSTFLAGS="-L${rust.out}/lib/rustlib/x86_64-apple-darwin/lib"
  '';

  postInstall = ''
    mkdir -p $out/share/emacs/site-lisp
    cp ${./site-start.el} $out/share/emacs/site-lisp/site-start.el
  '' +  stdenv.lib.optionalString stdenv.isDarwin ''
    mkdir -p $out/Applications
    mv nextstep/Emacs.app $out/Applications
    ln -s $out/remacs $out/emacs
    ln -s $out/remacsclient $out/emacsclient
  '';

  meta = with stdenv.lib; {
    description = "A community-driven Rust port of GNU Emacs, the extensible, customizable text editor";
    homepage    = http://www.gnu.org/software/emacs/;
    license     = licenses.gpl3Plus;
    maintainers = with maintainers; [ peel ];
    platforms   = platforms.darwin;

    longDescription = ''
      GNU Emacs is an extensible, customizable text editor—and more.  At its
      core is an interpreter for Emacs Lisp, a dialect of the Lisp
      programming language with extensions to support text editing.
      The features of GNU Emacs include: content-sensitive editing modes,
      including syntax coloring, for a wide variety of file types including
      plain text, source code, and HTML; complete built-in documentation,
      including a tutorial for new users; full Unicode support for nearly all
      human languages and their scripts; highly customizable, using Emacs
      Lisp code or a graphical interface; a large number of extensions that
      add other functionality, including a project planner, mail and news
      reader, debugger interface, calendar, and more.  Many of these
      extensions are distributed with GNU Emacs; others are available
      separately.
    '';
  };
}
