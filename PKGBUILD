# Maintainer: ibrokemypie <ibrokemypie@bastardi.net>
pkgname=nxengine-evo
pkgver=2.6.5.1
_ver=2.6.5-1
_langver=1.14
pkgrel=3
pkgdesc="A somewhat upgraded/refactored version of nxengine"
arch=('i686' 'x86_64')
url="https://github.com/isage/nxengine-evo"
license=('GPL3')
depends=(sdl2_mixer sdl2_image sdl2_ttf)
makedepends=(cmake libpng libjpeg)
source=("git+https://github.com/nxengine/nxengine-evo"
        "https://www.cavestory.org/downloads/cavestoryen.zip"
        "https://github.com/nxengine/translations/releases/download/v${_langver}/all.zip")
sha256sums=('SKIP'
            'aa87fa30bee9b4980640c7e104791354e0f1f6411ee0d45a70af70046aa0685f'
            '1dd85a8c230c5ebf23c6fd6283fe168d9bf4044339d1e93e324bd336165a4422')

pkgver() {
	cd "${_pkgname}"
	git describe --long --tags | sed 's/^v//;s/\([^-]*-g\)/r\1/;s/-/./g'
}

build() {
	cd "${_pkgname}"
	mkdir build
	cd build
    cmake -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_BUILD_TYPE=Release -DPORTABLE=ON -Wno-dev -DCMAKE_INSTALL_PREFIX=/usr ..
    make

	cd ../
    cp -r "../CaveStory/data/" "./"
    cp "../CaveStory/Doukutsu.exe" "./"
    cp -r "../data/" "./"
  
    ./build/nxextract
}

package() {
	cd "${_pkgname}/build"
	make DESTDIR="$pkgdir" install
}
