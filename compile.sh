export SITE=./dist/build/site/site
cabal build && \
  $SITE clean && \
  $SITE build
