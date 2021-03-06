# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gecode/gecode-3.7.3.ebuild,v 1.3 2013/03/02 19:59:26 hwoarang Exp $

EAPI="5"

inherit libtool
DESCRIPTION="Gecode is an environment for developing constraint-based systems and applications"
HOMEPAGE="http://www.gecode.org/"

if [[ ${PV} != 9999 ]]; then
	SRC_URI="http://www.gecode.org/download/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
else
	inherit subversion
	ESVN_REPO_URI="https://svn.gecode.org/svn/gecode/trunk"
	ESVN_USER = "anonymous"
fi


SLOT="0"
LICENSE="MIT"
IUSE="doc examples gist"

DEPEND="gist? (
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	media-libs/freetype
	media-libs/libpng
	>=dev-libs/glib-2
)"
RDEPEND="${DEPEND}"

src_configure() {
	econf \
		--disable-examples \
		$(use_enable gist qt) \
		$(use_enable gist)
}

src_compile() {
	default
	use doc && emake doc
}

src_install() {
	default

	if use doc; then
		dohtml -r doc/html/
		einfo "HTML documentation has been installed into " \
			"/usr/share/doc/${PF}/html"
	fi

	if use examples; then
		docinto examples
		doins examples/*.cpp
		einfo "Example C++ programs have been installed into " \
			"/usr/share/doc/${PF}/examples"
	fi
}
