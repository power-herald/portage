# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for the power-herald Telegram bot daemon"

ACCT_USER_ID=-1
ACCT_USER_GROUPS=( power-herald )
ACCT_USER_HOME="/var/lib/power-herald"
ACCT_USER_HOME_OWNER="power-herald:power-herald"
ACCT_USER_SHELL="/sbin/nologin"

acct-user_add_deps
