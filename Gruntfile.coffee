module.exports = (grunt) ->

	# Project configuration.
	grunt.initConfig

		# Metadata.
		pkg: grunt.file.readJSON("package.json")
		banner: "/*! Web Experience Toolkit (WET) / Boîte à outils de l'expérience Web (BOEW) wet-boew.github.io/wet-boew/License-en.html / wet-boew.github.io/wet-boew/Licence-fr.html\n" +
				" - v<%= pkg.version %> - " + "<%= grunt.template.today(\"yyyy-mm-dd\") %>\n*/\n"

		# Task configuration.

		# Builds the demos
		assemble:
			options:
				prettify:
					indent: 2
				marked:
					sanitize: false
				production: false
				data: "src/data/**/*.{yml,json}"
				assets: "dist"
				helpers: "src/helpers/helper-*.js"
				partials: ["src/includes/**/*.hbs"]

			site:
				cwd: "src"
				src: ["*.hbs"]
				dest: "dist/"
				expand: true

		copy:
			revealjs:
				cwd: "lib/reveal.js"
				src: [
					"**/*.min.js",
					"**/*.min.css"
				]
				dest: "dist/reveal.js"
				expand: true

		clean:
			dist: "dist"

		"gh-pages":
			options:
				message: "Travis build " + process.env.TRAVIS_BUILD_NUMBER
			src: [
				"dist/**/*.*",
				"*.html",
				"*.md",
				"*.txt"
			]


	# These plugins provide necessary tasks.
	@loadNpmTasks "assemble"
	@loadNpmTasks "grunt-contrib-clean"
	@loadNpmTasks "grunt-contrib-copy"
	@loadNpmTasks "grunt-gh-pages"

	# Load custom grunt tasks form the tasks directory
	@loadTasks "tasks"

	# Default task.
	@registerTask "default", ["dist"]

	@registerTask "dist", ["clean:dist", "copy", "html"]
	@registerTask "html", ["assemble"]
	@registerTask "deploy", ["gh-pages"]

	@