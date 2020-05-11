#!/bin/bash
set -ex

rm -rf dest || exit 0;

mkdir -p dest

# compile JS using Elm
elm make src/Main.elm --optimize --output dest/elm-temp.js

# minify with uglifyjs
uglifyjs dest/elm-temp.js --compress 'pure_funcs="F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9",pure_getters,keep_fargs=false,unsafe_comps,unsafe' | uglifyjs --mangle --output=dest/elm.js

rm dest/elm-temp.js

# copy sounds and html
cp -R index.html assets dest

# publish to itch.io
./butler push dest unsoundscapes/garden-of-eels:html
