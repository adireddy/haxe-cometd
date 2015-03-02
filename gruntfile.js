module.exports = function (grunt) {

    grunt.initConfig({
        pkg: grunt.file.readJSON("package.json"),

        haxe: {
            project: {
                hxml: "build.hxml"
            }
        }
    });

    grunt.loadNpmTasks("grunt-exec");
    grunt.loadNpmTasks("grunt-haxe");
    grunt.loadNpmTasks("grunt-contrib-uglify");
    grunt.loadNpmTasks("grunt-contrib-copy");

    grunt.registerTask("default", ["haxe"]);
};