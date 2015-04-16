# call Mac OSX's "say" command
# watch {type: 'say': value: value}
# write {type: 'say': value: value, result: ['success', 'fail']}

{exec} = require 'child_process'

module.exports = (linda) ->

  config = linda.config

  ts = linda.tuplespace(config.linda.space)

  linda.io.on 'connect', ->

    linda.debug "watching {type: 'say'} in tuplespace '#{ts.name}'"
    linda.debug "=> #{config.linda.url}/#{ts.name}?type=say&value=hello"

    ts.watch {type: 'say'}, (err, tuple) ->
      return if tuple.data.response?
      if err
        linda.debug err
        return
      linda.debug tuple
      if tuple.data?.value?
        linda.debug cmd = "say '#{tuple.data.value.toString().sanitize()}'"
        exec cmd, (err, stdout, stderr) ->
          data = tuple.data
          data.response = if err then "fail" else "success"
          ts.write data

  String::sanitize = ->
    return @.replace(/[\`\"\'\r\n;\|><]/g, '')
