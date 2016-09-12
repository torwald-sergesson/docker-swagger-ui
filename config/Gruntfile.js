module.exports = function(grunt) {
  // load all grunt-* tasks automatically
  // so you don't need to provision them manually inside
  // gruntfile
  require('time-grunt')(grunt);
  //require('load-grunt-tasks')(grunt);
  require('jit-grunt')(grunt);

  // setup configuration
  grunt.initConfig({
    // task to watch changes in real time to specified files and run tasks
    // if we get bower.json updated and install the change immediately
    // also run jshint, jscs checker on changed JS files
    watch: {
      // check if swagger files were changed and build new swagger file
      swagger: {
        //
        files: '/src/swagger/**/*.yaml',
        tasks: ['shell:swagger'],
		options: {
			livereload: 8081
		}
      }
    },
    shell: {
      // generate swagger file
      swagger: {
        command: function() {
          return 'bash ./mk_swagger.sh';
        }
      },
      // validate swagger file
      validateswagger: {
        command: function () {
          return 'swagger validate /src/swagger/main.yaml';
        }
      }
    }
  });

  grunt.registerTask('swagger', ['shell:swagger']);
  grunt.registerTask('validateswagger', ['shell:validateswagger']);
};

