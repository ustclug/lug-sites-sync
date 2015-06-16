# lug-sites-sync

Script to sync lug.ustc.edu.cn/sites pages.

Only used for lug.ustc.edu.cn mainpage server.

## Installation

    # dpkg -b src/ lug-sites-sync.deb
    # dpkg -i ./lug-sites-sync.deb

or use debuild:

    $ cd src/
    $ debuild -k<signing_key_id>
    # dpkg -i ../*.deb
