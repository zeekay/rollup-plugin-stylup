import fs             from 'fs'
import path           from 'path'
import stylus         from 'stylus'
import {createFilter} from 'rollup-pluginutils'

export default (opts = {}) ->
  filter     = createFilter(opts.include, opts.exclude)
  sourceMap  = opts.sourceMap ? false
  plugins    = opts.plugins   ? []

  name: 'stylup'
  transform: (code, id) ->
    if !filter(id) or path.extname(id) != '.styl'
      return null

    relativePath = path.relative process.cwd(), id

    style = stylus code
    style.set 'filename', relativePath

    if sourceMap
      style.set 'sourcemap', inline: true

    for plugin in plugins
      try
        style.use plugin
      catch err
        console.error 'Failed to use plugin', plugin.toString()
        throw err

    new Promise (resolve, reject) ->
      style.render (err, css) ->
        return reject err if err?

        resolve
          id:  "#{id}.css"
          code: "export default #{JSON.stringify(css)};"
          map:
            mappings: ''
