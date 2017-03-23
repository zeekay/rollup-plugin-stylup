require 'shortcake'

use 'cake-bundle'
use 'cake-outdated'
use 'cake-publish'
use 'cake-test'
use 'cake-version'

option '-b', '--browser [browser]', 'browser to use for tests'
option '-g', '--grep [filter]',     'test filter'
option '-t', '--test [test]',       'specify test to run'
option '-v', '--verbose',           'enable verbose test logging'

task 'clean', 'clean project', ->
  exec 'rm -rf dist'

task 'build', 'build project', ->
  bundle.write
    entry:    'src/index.coffee'
    formats:  ['cjs', 'es']
    external: true

task 'watch', 'watch project', ->
  build = (filename) ->
    console.log filename, 'modified, rebuilding'
    invoke 'build' if not running 'build'
  watch 'src/*.coffee', build
  watch 'node_modules/', build, watchSymlink: true
