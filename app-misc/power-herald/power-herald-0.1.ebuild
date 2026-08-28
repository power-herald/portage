# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1

DESCRIPTION="Telegram Bot server for power source outage notifications"
HOMEPAGE="https://github.com/idokka/power-herald"
SRC_URI="https://github.com/idokka/power-herald/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+mariadb sqlite"
REQUIRED_USE="^^ ( mariadb sqlite )"

RDEPEND="
	acct-group/power-herald
	acct-user/power-herald
	$(python_gen_cond_dep '
		dev-python/aiogram[${PYTHON_USEDEP}]
		dev-python/aiohttp[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/ping3[${PYTHON_USEDEP}]
		dev-python/sqlalchemy[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/python-dotenv[${PYTHON_USEDEP}]
	')
	mariadb? ( $(python_gen_cond_dep 'dev-python/pymysql[${PYTHON_USEDEP}]') )
"

src_install() {
	distutils-r1_src_install

	if use sqlite; then
		sed -i \
			-e '/^  driver:/c\  driver: "sqlite"' \
			-e '/^  database:/c\  database: "/var/lib/power-herald/power_herald.db"' \
			config.yaml || die "failed to configure SQLite database path"
	fi

	insinto /etc/power-herald
	insopts -m0640 -o power-herald -g power-herald
	doins config.yaml
	insopts -m0644 -o power-herald -g power-herald
	doins locale.yaml

	newinitd "${FILESDIR}/power-herald.initd" power-herald
	newconfd "${FILESDIR}/power-herald.confd" power-herald

	diropts -m0750 -o power-herald -g power-herald
	keepdir /var/log/power-herald
	if use sqlite; then
		keepdir /var/lib/power-herald
	fi

	dodoc README.md API.md DEPLOYMENT.md OPENRC_SETUP.md
}

pkg_postinst() {
	elog "Edit /etc/power-herald/config.yaml with your bot token, database"
	elog "credentials and webhook settings before starting the service."
	elog
	elog "Then enable and start the daemon with:"
	elog "  rc-update add power-herald default"
	elog "  rc-service power-herald start"
}
