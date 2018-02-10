pkg_name="cyrus-imapd"
pkg_origin="core"
pkg_version="3.0.5"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("MIT-CMU")
pkg_source="ftp://ftp.cyrusimap.org/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz"
pkg_sig_source="ftp://ftp.cyrusimap.org/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz.sig"
pkg_shasum="ae5fe3f33f75ef2d3964ea38ae7e01207da8050a71a21dea30c4f8d4bd159ad1"
pkg_deps=(core/glibc core/openssl)
pkg_build_deps=(
  core/make
  core/gcc
  core/gnupg
  core/expect
  core/bison
  core/flex
  core/pkg-config
  mozillareality/jansson
  core/cyrus-sasl
  core/icu
  core/perl
)
# pkg_lib_dirs=(lib)
# pkg_include_dirs=(include)
# pkg_bin_dirs=(bin)
# pkg_pconfig_dirs=(lib/pconfig)
# pkg_svc_run="haproxy -f $pkg_svc_config_path/haproxy.conf"
# pkg_exports=(
#   [host]=srv.address
#   [port]=srv.port
#   [ssl-port]=srv.ssl.port
# )
# pkg_exposes=(port ssl-port)
# pkg_binds=(
#   [database]="port host"
# )
# pkg_binds_optional=(
#   [storage]="port host"
# )
# pkg_interpreters=(bin/bash)
# pkg_svc_user="hab"
# pkg_svc_group="$pkg_svc_user"
# pkg_description="Some description."
# pkg_upstream_url="http://example.com/project-name"

# Below is the default behavior for this callback. Anything you put in this
# callback will override this behavior. If you want to use default behavior
# delete this callback from your plan.
# @see https://www.habitat.sh/docs/reference/plan-syntax/#callbacks
# @see https://github.com/habitat-sh/habitat/blob/master/components/plan-build/bin/hab-plan-build.sh
do_download() {
  do_default_download
  # download_file "${pkg_sig_source}" "${pkg_name}-${pkg_version}.tar.gz.sig" \
  #  "4d40d18a213fb606c789b61715e27450382dc67409c9cb527d2cea20f2b1939f"
  # download_file ftp://ftp.gnu.org/gnu/gnu-keyring.gpg gnu-keyring.gpg \
  #  "bc124f84b9bb21933d52adbec24276f1ac8f0e50e0f22eba0144dfd0e5288752"
}

do_verify() {
  do_default_verify
  # verify_file "${pkg_name}-${pkg_version}.tar.gz.sig" \
  #   "4d40d18a213fb606c789b61715e27450382dc67409c9cb527d2cea20f2b1939f"
  # build_line "Verifying ${pkg_name}-${pkg_version}.tar.gz signature"
  # GNUPGHOME=$(mktemp -d -p "$HAB_CACHE_SRC_PATH")
  # rm -r "$GNUPGHOME" || true
  # gpg --import gnu-keyring.gpg
  # attach
  # expect -c "spawn gpg --edit-key gnu-keyring.gpg trust quit; send \"5\ry\r\"; expect eof"
  # gpg --keyserver pgp.mit.edu --recv-keys F758CE318D77295D
  # gpg --batch --verify "${HAB_CACHE_SRC_PATH}"/${pkg_name}-${pkg_version}.tar.gz.sig \
  #   "${HAB_CACHE_SRC_PATH}"/${pkg_name}-${pkg_version}.tar.gz
  # rm -r "$GNUPGHOME"
  # build_line "Signature verified for ${pkg_name}-${pkg_version}.tar.gz"
}

# Below is the default behavior for this callback. Anything you put in this
# callback will override this behavior. If you want to use default behavior
# delete this callback from your plan.
# @see https://www.habitat.sh/docs/reference/plan-syntax/#callbacks
# @see https://github.com/habitat-sh/habitat/blob/master/components/plan-build/bin/hab-plan-build.sh
do_build() {
  export LD_LIBRARY_PATH="$(hab pkg path core/gcc)/lib"
  export CPATH="$CPATH:$(hab pkg path core/cyrus-sasl)/include/sasl"
  ./configure --prefix=$pkg_prefix
  make
}
