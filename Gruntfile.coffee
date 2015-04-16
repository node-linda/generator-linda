'use strict'

module.exports = (grunt) ->

  require 'coffee-errors'

  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-jsonlint'
  grunt.loadNpmTasks 'grunt-simple-mocha'
  grunt.loadNpmTasks 'grunt-notify'

  grunt.registerTask 'test',    [ 'jsonlint', 'coffeelint', 'simplemocha' ]
  grunt.registerTask 'default', [ 'test' ]

  grunt.initConfig

    jsonlint:
      config:
        src: [
          'app/**/*.json'
          '*.json'
          '!node_modules/**'
        ]

    coffeelint:
      options:
        max_line_length:
          value: 120
        indentation:
          value: 2
        newlines_after_classes:
          level: 'error'
        no_empty_param_list:
          level: 'error'
        no_unnecessary_fat_arrows:
          level: 'ignore'
      dist:
        files: [
          { expand: yes, src: [ '*.coffee' ] }
          { expand: yes, cwd: 'app/', src: [ '**/*.coffee' ] }
          { expand: yes, cwd: 'tests/', src: [ '*.coffee' ] }
        ]

    simplemocha:
      options:
        ui: 'bdd'
        reporter: 'spec'
        compilers: 'coffee:coffee-script'
        ignoreLeaks: yes
      dist:
        src: [ 'tests/test_*.coffee' ]
