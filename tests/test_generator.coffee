'use strict'

process.env.NODE_ENV = 'test'

path = require 'path'

assert  = require('yeoman-generator').assert
helpers = require('yeoman-generator').test

describe 'generator-linda', (done) ->

  before (done) ->
    helpers.run path.resolve 'app'
    .inDir path.resolve 'tests/tmp'
    .on 'end', done

  it 'have create files', ->
    assert.file [
      'README.md'
      'package.json'
      'Procfile'
      'Gruntfile.coffee'
      'config.json'
      'scripts'
      'libs'
    ]
