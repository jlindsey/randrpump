module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    clean:
      public:
        src: [
          'public/*.html',
          'public/*.css',
          'public/*.js',
          'public/img'
        ]

    copy:
      images:
        files: [
          src: ['src/img/*']
          dest: 'public/img'
          filter: 'isFile'
          flatten: true
          expand: true
        ]

    concat:
      options:
        separator: '\n'
      css:
        src: [
          'src/css/bootstrap.min.css',
          'src/css/bootstrap-responsive.min.css'
          'src/css/screen.css'
        ]
        dest: 'public/screen.css'

    cssmin:
      options:
        keepSpecialComments: 0
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
      screen:
        files:
          'public/screen.min.css': ['public/screen.css']

    jade:
      site:
        files:
          'public/index.html': 'src/jade/index.jade'

    develop:
      server:
        file: 'server.js'

    reload:
      port: 3000
      proxy:
        host: 'localhost'
        port: 3001

    watch:
      css:
        files: ['src/css/*.css']
        tasks: ['concat', 'cssmin', 'reload']

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-develop'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-reload'

  grunt.registerTask 'default', ['clean', 'copy', 'concat', 'cssmin', 'jade']
  grunt.registerTask 'dev', ['default', 'develop', 'reload', 'watch']
