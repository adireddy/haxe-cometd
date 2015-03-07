module.exports = function (grunt) {

    grunt.initConfig({
         pkg: grunt.file.readJSON("package.json"),

         zip: {
             "cometd.zip": ["cometd/**", "haxelib.json"]
         }
     });

    grunt.loadNpmTasks("grunt-zip");
    grunt.registerTask("default", ["zip"]);
};