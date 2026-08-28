# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

MY_PN="magic_filter"

DESCRIPTION="Magic filter based on dynamic attribute getter, used by aiogram"
HOMEPAGE="
	https://github.com/aiogram/magic-filter
	https://pypi.org/project/magic-filter/
"
SRC_URI="https://files.pythonhosted.org/packages/source/m/magic-filter/${MY_PN}-${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
