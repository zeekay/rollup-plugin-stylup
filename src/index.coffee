import path   from 'path'
import stylus from 'stylus'

export default (opts = {}) ->
  opts.plugins   ?= []
  opts.sourceMap ?= true

  name: 'stylup'
  transform: (code, id) ->
    return if (path.extname id) != '.styl'

    relativePath = path.relative process.cwd(), id

    style = stylus code
    style.set 'filename', relativePath

    if opts.sourceMap
      style.set 'sourcemap', comment: false

    for plugin in opts.plugins
      try
        style.use plugin
      catch err
        console.error 'Failed to use plugin', plugin.toString()
        throw err

    new Promise (resolve, reject) ->
      style.render (err, css) ->
        return reject err if err?

        resolve
          id:   "#{id}.css"
          code: "export default #{JSON.stringify(css)};"
          map:  style.sourcemap
