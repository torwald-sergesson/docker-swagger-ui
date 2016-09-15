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
        tasks: ['shell:swagger_build'],
		options: {
			livereload: 8081
		}
      }
    },
    shell: {
      // generate swagger file
      // generate swagger file
      swagger_build: {
        command: function () {
          return 'bash ./mk_swagger.sh';
        }
      },
      // validation of swagger file
      swagger_validate:  {
        command: function () {
          return 'swagger validate /src/swagger/main.yaml';
        }
      }
    }
  });

  grunt.registerTask('swagger', 'Swagger default', [
    'shell:swagger_validate',
    'shell:swagger_build'
  ]);
  grunt.registerTask('swagger_validate', ['shell:swagger_validate']);
  grunt.registerTask('swagger_build', ['shell:swagger_build']);
};

