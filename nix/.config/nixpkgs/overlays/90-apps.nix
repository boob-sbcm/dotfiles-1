self: super: {

installApplication = 
  { name, appname ? name, version, src, description, homepage, 
    postInstall ? "", sourceRoot ? ".", ... }:
  with super; stdenv.mkDerivation {
    name = "${name}-${version}";
    version = "${version}";
    src = src;
    buildInputs = [ undmg unzip ];
    sourceRoot = sourceRoot;
    phases = [ "unpackPhase" "installPhase" ];
    installPhase = ''
      mkdir -p "$out/Applications/${appname}.app"
      cp -pR * "$out/Applications/${appname}.app"
    '' + postInstall;
    meta = with stdenv.lib; {
      description = description;
      homepage = homepage;
      platforms = platforms.darwin;
    };
  };

Dash = self.installApplication rec {
  name = "Dash";
  version = "4.5.1";
  sourceRoot = "Dash.app";
  src = super.fetchurl {
    url = https://kapeli.com/downloads/v4/Dash.zip;
    sha256 = "0z8365shmwn26c2fcwv18drmi1i06myj1wspc563kaic7g7z9l4v";
    # date = 2018-09-28T23:36:13-0700;
  };
 description = "Dash is an API Documentation Browser and Code Snippet Manager";
  homepage = https://kapeli.com/dash;
};

Docker = self.installApplication rec {
  name = "Docker";
  version = "18.06.1-ce-mac73";
  sourceRoot = "Docker.app";
  src = super.fetchurl {
    url = https://download.docker.com/mac/stable/Docker.dmg;
    sha256 = "19a7n36nkw20rrklr8qlp76l5xhn037avqfnk81rilghik1yla9l";
    # date = 2018-09-28T11:14:33-0700;
  };
  description = ''
    Docker CE for Mac is an easy-to-install desktop app for building,
    debugging, and testing Dockerized apps on a Mac
  '';
  homepage = https://store.docker.com/editions/community/docker-ce-desktop-mac;
};

Dropbox = self.installApplication rec {
  name = "Dropbox";
  version = "1.0";
  sourceRoot = "Dropbox.app";
  src = super.fetchurl {
    url = https://www.dropbox.com/download?plat=mac&full=1;
    name = "Dropbox.dmg";
    sha256 = "0mhh2lkivaykzqvc33nhz44lw5k3pbpnci01w3pjwdhxgd02x650";
    # date = 2018-09-28T11:14:33-0700;
  };
  description = ''
    Dropbox brings your files together, in one central place. They’re easy to find and safely synced across all your devices—so you can access them anytime, anywhere. No more wasting the day tracking down work.
  '';
  homepage = https://www.dropbox.com;
};

OnePassword = self.installApplication rec {
  name = "1Password";
  version = "7.2.1";
  sourceRoot = "1Password 7.app";
  src = super.fetchurl {
    url = "https://c.1password.com/dist/1P/mac7/1Password-${version}.zip";
    sha256 = "3ec43f6015f03768922982f067ee49fb776a6bbbeada6c3518480ede0ae039cb";
    # date = 2018-09-28T11:14:33-0700;
  };
  description = ''
    Go ahead. Forget your passwords. 1Password remembers them all for you. Save your passwords and log in to sites with a single click. It's that simple.
  '';
  homepage = https://1password.com;
};

ProtonmailBridge= self.installApplication rec {
  name = "ProtonmailBridge";
  version = "1.0.6";
  sourceRoot = "Protonmail\ Bridge.app";
  src = super.fetchurl {
    url = "https://protonmail.com/download/Bridge-Installer.dmg";
    sha256 = "1s3cvfv6p033a696gz5h5wv8l6miw0sw0xajpz394b2d1mf9282a";
    # date = 2018-09-28T14:23:15-0800;
  };
  description = "The ProtonMail Bridge is an application for paid users that runs on your computer in the background and seamlessly encrypts and decrypts your mail as it enters and leaves your computer. It allows for full integration of your ProtonMail account with any program that supports IMAP and SMTP such as Microsoft Outlook, Mozilla Thunderbird and Apple Mail.";
  homepage = https://protonmail.com/bridge/;
};

Spotify = self.installApplication rec {
  name = "Spotify";
  version = "1.0.6";
  sourceRoot = "Spotify.app";
  src = super.fetchurl {
    url = "https://download.scdn.co/Spotify.dmg";
    sha256 = "0xa11xbjkp7ai4i1k0gyda1m3rl84r47977y3p880fjciffrk7rr";
    # date = 2018-09-28T14:23:15-0800;
  };
  description = "Spotify is a digital music service that gives you access to millions of songs.";
  homepage = https://spotify.com/;
};

Tunnelblick = self.installApplication rec {
name = "Tunnelblick";
  version = "3.7.7,5150";
  sourceRoot = "Tunnelblick.app";
  src = super.fetchurl {
    url = "https://download.scdn.co/Spotify.dmg";
    sha256 = "afab743ca603810b5724e7d25848b67fc5dee6fc66f496b297916a4d185a8b53";
    # date = 2018-09-28T14:23:15-0800;
  };
  description = "Spotify is a digital music service that gives you access to millions of songs.";
  homepage = https://spotify.com/;
};

}
