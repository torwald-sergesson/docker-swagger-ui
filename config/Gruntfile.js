module.exports = function(grunt) {
  var PROJECT_FOLDER = '/home/project/'
  // load all grunt-* tasks automatically
  // so you don't need to provision them manually inside
  // gruntfile
  require('time-grunt')(grunt);
  //require('load-grunt-tasks')(grunt);
  require('jit-grunt')(grunt);

  var swagger_options = grunt.file.readYAML(PROJECT_FOLDER + '.swagger.conf');


  // make swagger file
  function _makeSwagger(input, output, label) {
    var command = 'bash ./mk_swagger.sh ' + label + ' ' + input; 
    if (output) {
      command = ' ' + output;
    }
    return command;
  }

  // make swagger file by label
  function makeSwagger(label, output) {
    var input = swagger_options['swaggers'][label];
    return _makeSwagger(input, output, label);
  }

  // make all swagger files
  function makeAllSwagger() {
    var commands = [];
    for (var label in swagger_options['swaggers']) {
      commands.push(makeSwagger(label, ''));
    }
    return commands;
  }

  // setup configuration
  grunt.initConfig({
    // task to watch changes in real time to specified files and run tasks
    // if we get bower.json updated and install the change immediately
    // also run jshint, jscs checker on changed JS files
    watch: {
      // check if swagger files were changed and build new swagger file
      swagger: {
        //
        files: PROJECT_FOLDER + swagger_options['sources'],
        tasks: ['shell:swagger'],
		options: {
			livereload: 8081
		}
      }
    },
    shell: {
      // generate swagger file
      swagger: {
        command: function (label, output) {
          return makeAllSwagger().join(' && ');
        }
      }
    }
  });

  grunt.registerTask('swagger', ['shell:swagger']);
  grunt.registerTask('default', ['shell:swagger']);
};

