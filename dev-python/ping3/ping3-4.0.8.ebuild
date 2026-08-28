# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="A pure python3 version of ICMP ping implementation using raw socket"
HOMEPAGE="
	https://github.com/kyan001/ping3
	https://pypi.org/project/ping3/
"
SRC_URI="https://files.pythonhosted.org/packages/source/p/ping3/ping3-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
