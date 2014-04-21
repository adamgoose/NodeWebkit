'use strict'

module.exports = (grunt) ->

    grunt.initConfig

        watch:
            scripts:
                files: ['app/assets/coffeescript/**/*.coffee']
                tasks: ['clear', 'coffee', 'concat', 'uglify:build']
                options:
                    spawn: false
                    livereload: true
            sass:
                files: ['app/assets/sass/**/*.scss']
                tasks: ['clear', 'sass:build', 'autoprefixer']
                options:
                    spawn: false
                    livereload: true

        nodewebkit:
            options:
                build_dir: './builds'
                credits: './credits.html'
                version: '0.9.1'
                mac: true
                win: false
                linux32: false
                linux64: false
            src:
                [
                    './app/package.json',
                    './app/public/**/*',
                    './app/index.html'
                ]

        coffee:
            options:
                bare: true

            glob_to_multiple:
                expand: true
                cwd: 'app/assets/coffeescript'
                src: ['**/*.coffee']
                dest: 'app/assets/javascripts/'
                ext: '.js'

        concat:
            build:
                options:
                    banner: "'use strict';\n"
                    process: (src, filepath) ->
                        "// Source: #{filepath}\n #{src.replace /(^|\n)[ \t]*('use strict'|"use strict");?\s*/g, '$1'}"

                src: [
                    'app/assets/javascripts/**/*'
                ]
                dest: 'app/public/js/main.js'
        sass:
            build:
                options:
                    style: 'compressed'

                files:
                    'app/public/css/main.css': 'app/assets/sass/main.scss'
        autoprefixer:
            no_dest:
                src: [
                    'app/public/css/main.css'
                ]

        uglify:
            build:
                options:
                    report: 'min'
                files:
                    'app/public/js/main.min.js': ['app/public/js/main.js']

    grunt.loadNpmTasks 'grunt-autoprefixer'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-concat'
    grunt.loadNpmTasks 'grunt-contrib-sass'
    grunt.loadNpmTasks 'grunt-contrib-uglify'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-node-webkit-builder'


    grunt.registerTask 'clear', ->
        console.log "\u001B[2J\u001B[0;0f"

    grunt.registerTask 'default', ['watch']
