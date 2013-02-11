BOOTSTRAP_SOURCE=$(shell pwd)/src/bootstrap
BOOTSWATCH_SOURCE=$(shell pwd)/src/bootswatch
FA_SOURCE=$(shell pwd)/src/fontawesome
JQUERY_SOURCE=$(shell pwd)/src/jquery
JQUERYUI_SOURCE=$(shell pwd)/src/jqueryui
JQUERYM_SOURCE=$(shell pwd)/src/jquerymobile


JS_DEST=$(shell pwd)/build/js
CSS_DEST=$(shell pwd)/build/css
IMG_DEST=$(shell pwd)/build/img
FONT_DEST=$(shell pwd)/build/font

DATE=$(shell date +%I:%M%p)
CHECK=\033[32mX\033[39m
HR=\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#


all: stage4 
	@echo "\v"
	@echo "Finished building Rocketboots."
	@echo "${HR}\n"

stage1: bootstrap fontawesome

stage2: stage1 jquery

stage3: stage2 jqueryui

stage4: stage3 jquerymobile

jquery-all: jquery jqueryui jquerymobile

bootstrap: | buildprep
	@(cd ./src/bootstrap/ && npm install && make)

jquery: | buildprep
	@echo "\v"
	@echo "Building jQuery..."
	@echo "${HR}\n"
	@(cd ${JQUERY_SOURCE} && npm install)
	@(cd ${JQUERY_SOURCE} && grunt && grunt dist:${JS_DEST})


# needs npm install phantomjs -g
jqueryui: | buildprep
	@echo "\v"
	@echo "Building jQuery UI..."
	@echo "${HR}\n"
	@(cd ${JQUERYUI_SOURCE} && npm install)
	@(cd ${JQUERYUI_SOURCE} && grunt build) # force until htmllint error is resolved
	cp ${JQUERYUI_SOURCE}/dist/*.js ${JS_DEST}
	cp ${JQUERYUI_SOURCE}/dist/*.css ${CSS_DEST}

jquerymobile: | buildprep
	@echo "\v"
	@echo "Building jQuery Mobile..."
	@echo "${HR}\n"
	@(cd ${JQUERYM_SOURCE} && make docs)
	cp ${JQUERYM_SOURCE}/compiled/*.js ${JS_DEST}
	cp ${JQUERYM_SOURCE}/compiled/*.css ${CSS_DEST}

bootswatch: | buildprep
	@echo "\v"
	@echo "Parsing Bootswatch..."
	@echo "${HR}\n"
	#@(cd ${BOOTSWATCH_SOURCE} && ./some-scirpt)
	@echo "Fake Done\n"

fontawesome: fontawesome-css

fontawesome-css: fontawesome-font
	cp ${FA_SOURCE}/css/* ${CSS_DEST}

fontawesome-font:
	@echo "\vCopying Font Awesome to build directory"
	@echo "${HR}\n"
	cp ${FA_SOURCE}/font/* ${FONT_DEST}


# will make the final themes responsive
responsive:


buildprep:
	@mkdir -p ${JS_DEST} ${CSS_DEST} ${IMG_DEST} ${FONT_DEST}

clean:
	@rm -rf $(pwd)/build
	@rm -rf $(pwd)/src/*

# vim: set ts=8 : #
