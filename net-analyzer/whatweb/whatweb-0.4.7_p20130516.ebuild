# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv$

EAPI=5

USE_RUBY="ruby20"
inherit ruby-ng git-2

DESCRIPTION="Next generation web scanner, identifies what software websites are running"
HOMEPAGE="http://www.morningstarsecurity.com/research/whatweb"
#SRC_URI="http://www.morningstarsecurity.com/downloads/${P}.tar.gz"
#SRC_URI="http://dev.gentoo.org/~zerochaos/distfiles/${P}.tar.gz"
EGIT_REPO_URI="https://github.com/urbanadventurer/WhatWeb.git"
EGIT_COMMIT="f35d0265c04605dbddec5ea9af418ebd796eef60"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="json"

DEPEND="dev-lang/ruby"
RDEPEND="${DEPEND}
	json? ( dev-ruby/json )"

#future rdepend:
#dns: em-resolv-replace
#mongodb: bison bson_ext mongo rchardet

ruby-ng_src_prepare() {
	# fix install
	sed -i 's|plugins-disabled||g' Makefile || die
	sed -i 's|$(DOCPATH)/$(NAME)|$(DOCPATH)/${PF}|g' Makefile || die
#	sed -i -e 's:#!/usr/bin/env ruby:#!/usr/bin/env ruby18:' whatweb || die
}

ruby-ng_src_install() {
	dodir /usr/share/doc/"${PF}"
	DESTDIR="${D}" emake install || die "install failed"
	dodoc CHANGELOG README whatweb.xsl || die
}
