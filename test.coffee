{resolve} = require './web-path'
test = require 'tape'

test 'resolve', (assert) ->
  assert.is resolve('/a/b/c', 'd.html'), '/a/b/d.html'
  assert.is resolve('/a/b/c/', 'd.html'), '/a/b/c/d.html'
  assert.end()
