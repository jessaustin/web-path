###
 copyright (c) 2014 Jess Austin <jess.austin@gmail.com>, MIT license

 Node's built-in path module doesn't know how trailing slashes are used on the
 web. The replacement functions in this module know how to deal with trailing
 slashes. For example:

    > path.resolve('/a/b/c', 'd.html');
    '/a/b/c/d.html'
    > webPath.resolve('/a/b/c', 'd.html');
    '/a/b/d.html'
    > webPath.resolve('/a/b/c/', 'd.html');
    '/a/b/c/d.html'
###

# replace anything other than two periods after the last slash with a single
# period
trimBackToSlash = (str) ->    # this would be a one-liner if we had look-behind
  s = str.replace /(?:^)(?!\.\.$)[^/]*$/, '.'                  # there was no slash
  s.replace /(?:\/)(?!\.\.$)[^/]*$/, '/.'                 # keep the slash

{join, resolve, relative} = require 'path'

module.exports =
  join: (paths...) ->
    last = paths.pop()
    join (trimBackToSlash p for p in paths)..., last

  resolve: (from..., to) ->
    (resolve (trimBackToSlash f for f in from)..., to) +
    if to.match /.\/\.?\.?$/ then '/' else ''

  relative: (from, to) ->
    (relative (trimBackToSlash from), to) or '.'
