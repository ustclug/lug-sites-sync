#!/bin/sh

# variables
readonly OPENSUSE_GUIDE_WEBSITE="https://gitcafe.com/winland0704/opensuse-guide.git"
readonly OPENSUSE_GUIDE_PATH="/var/www/sites/opensuse-guide/"
readonly QTGUIDE_WEBSITE="https://git.oschina.net/qtguide/qtguide.git"
readonly QTGUIDE_PATH="/var/www/sites/qtguide/"

# Check whether this script is run as www-data.
check_user()
{
    if [ ! "x$(whoami)" = "xwww-data" ]; then
        echo "not running as www-data." 1>&2
        return 1
    else
        return 0
    fi
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

    local result1
    local result2

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
