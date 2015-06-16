#!/bin/sh
# -*- coding: utf-8 -*-
# pull script for https://lug.ustc.edu.cn/sites.
# author: hosiet

# variables

OPENSUSE_GUIDE_WEBSITE="https://gitcafe.com/winland0704/opensuse-guide.git"
QTGUIDE_WEBSITE="https://git.oschina.net/qtguide/qtguide.git"

OPENSUSE_GUIDE_PATH="/var/www/sites/opensuse-guide/"
QTGUIDE_PATH="/var/www/sites/qtguide/"

# Check whether this script is run as root.
check_privilege()
{
    if [ ! "x$(whoami)" = "xroot" ]; then
        echo "not running as root."
        return 1
    else
        return 0
    fi
}

post_pull_fail()
{
    return
}

post_pull_success()
{
    return
}

# Process pull
# $1 is PATH and $2 is name
process_pull()
{
    cd $1
    git pull --verbose --ff --all --force
    chown www-data:www-data . -R
    if [ ! "x$?" = "x0" ]; then
        echo "exception happened while updating $2"
        post_pull_fail $2
        return 1
    else
        post_pull_success $2
        return 0
    fi
}

# Main procedure.
main_procedure()
{
    if [ ! check_privilege ]; then
        return 1
    fi

    process_pull ${QTGUIDE_PATH} "qtguide"
    result1=$?
    process_pull ${OPENSUSE_GUIDE_PATH} "opensuse-guide"
    result2=$?

    if test "x${result1}" = "x0" -a "x${result2}" = "x0"; then
        return 0
    else
        return 1
    fi
}

# main
main_procedure
