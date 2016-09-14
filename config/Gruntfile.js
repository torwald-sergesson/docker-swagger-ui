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
        tasks: ['shell:swagger:build'],
		options: {
			livereload: 8081
		}
      }
    },
    shell: {
      // generate swagger file
      swagger: {
        command: function(command) {
          if (command === 'build') {
            return 'bash ./mk_swagger.sh';
          } else if (command === 'validate') {
            return 'swagger validate /src/swagger/main.yaml';
          }
        }
      }
    },
    // multi task for swagger
    swagger: {
      validate: 'validate',
      build: 'build'
    },
  });

  grunt.registerMultiTask('swagger', 'Swagger operations', function() {
    grunt.
    task.
    run('shell:swagger:' + this.data);
  });
};

