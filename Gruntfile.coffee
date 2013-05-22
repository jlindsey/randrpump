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

    haml:
      options:
        rubyHamlCommand: 'haml -t ugly -f html5'
      site:
        files: [
          src: ['src/haml/*.haml']
          dest: 'public/'
          ext: '.html'
          flatten: true
          expand: true
        ]

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-haml'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'

  grunt.registerTask 'default', ['clean', 'copy', 'concat', 'cssmin', 'haml']
