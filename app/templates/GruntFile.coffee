module.exports = (grunt) ->

  # Project configuration
  #
  grunt.initConfig
    pkg:    grunt.file.readJSON( "package.json" )

    clean:
        dist:
            src: [ "lib" ]

    coffee:
      default:
        files: [
            expand: true            # Enable dynamic expansion.
            cwd: "src/"             # Src matches are relative to this path.
            src: [ "**/*.coffee" ]  # Actual pattern(s) to match.
            dest: "lib/"            # Destination path prefix.
            ext: ".js"              # Dest filepaths will have this extension.
        ]

    watch:
        src:
            files: [ "src/**/*.coffee" ]
            tasks: [ "coffee" ]

    titaniumifier:
        module:
            files:
                ".": "."

    mochaTest:
        dev:
            options:
                reporter:       "spec"
                require:        [ "coffee-script/register", "test/blanket" ]
            src: [
                "test/unit/*.js"
                "test/unit/*.coffee"
                "test/api/*.js"
                "test/api/*.coffee"
            ]

        "test-xunit":
            options:
                reporter:       "xunit"
                captureFile:    "dist/coverage/test-results.xml"
                quiet:          true
                require:        [ "coffee-script/register", "test/blanket" ]
            src: [
                "test/unit/*.js"
                "test/unit/*.coffee"
                "test/api/*.js"
                "test/api/*.coffee"
            ]

        "coverage-cobertura":
            options:
                reporter:       "mocha-cobertura-reporter"
                captureFile:    "dist/coverage/coverage.xml"
                quiet:          true
                coverage:       true
            src: [
                "test/unit/*.js"
                "test/unit/*.coffee"
                "test/api/*.js"
                "test/api/*.coffee"
            ]

        "coverage-html":
            options:
                reporter:       "html-cov"
                captureFile:    "dist/coverage/coverage.html"
                quiet:          true
                coverage:       true
            src: [
                "test/unit/*.js"
                "test/unit/*.coffee"
                "test/api/*.js"
                "test/api/*.coffee"
            ]

    # These plugins provide the necessary tasks
    #
    grunt.loadNpmTasks "grunt-contrib-coffee"
    grunt.loadNpmTasks "grunt-contrib-watch"
    grunt.loadNpmTasks "grunt-mocha-test"
    grunt.loadNpmTasks "grunt-contrib-compress"
    grunt.loadNpmTasks "grunt-contrib-clean"
    grunt.loadNpmTasks "grunt-titaniumifier"

    # Default tasks
    #
    grunt.registerTask "default",   [ "clean", "coffee", "titaniumifier" ]
    grunt.registerTask "test",      [ "clean", "coffee", "mochaTest:dev" ]
    grunt.registerTask "coverage",  [ "clean", "coffee", "mochaTest:test-xunit", "mochaTest:coverage-cobertura", "mochaTest:coverage-html" ]
