
TARGET = dest

# PAGES = about articles/index books/index core-doc/index index irc/index mailing-lists/index links/index site-resources/index tutorials/index web-forums/index

# SUBDIRS = articles books core-doc irc links mailing-lists tutorials site-resources source source/arcs web-forums

include defs.mak

SOURCES = $(addprefix src/,$(addsuffix .html.wml,$(PAGES)))

DESTS = $(patsubst src/%.html.wml,$(TARGET)/%.html,$(SOURCES))

RAW_FILES = $(IMAGES)
RAW_FILES_SOURCES = $(addprefix src/,$(RAW_FILES))
RAW_FILES_DEST = $(addprefix $(TARGET)/,$(RAW_FILES))

# PACKAGES_DIR = $(TARGET)/download/arcs
# PACKAGES = $(shell cd temp && cd lk-module-compiler-final && ls)
# PACKAGES_DESTS = $(addprefix $(PACKAGES_DIR)/,$(PACKAGES))

SUBDIRS_DEST = $(addprefix $(TARGET)/,$(SUBDIRS))

LATEMP_WML_INCLUDE_PATH =$(shell latemp-config --wml-flags)

WML_FLAGS += --passoption=2,-X3074 --passoption=3,-I../lib/ --passoption=7,"-S imgsize" -DROOT~.

WML_FLAGS += -DLATEMP_THEME=sinorca-2.0 -DLATEMP_SERVER=hackers

WML_FLAGS += $(LATEMP_WML_INCLUDE_PATH) -I../lib/

RSYNC = rsync --progress --verbose --rsh=ssh

LIBRARY_FILES = template.wml lib/MyNavData.pm

# This is a file that does not change or is timestamped from invocation
# to inovcation of this makefile. Useful for synchronizing uploads.
UNCHANGED_FILE = unchanged

all: dest $(SUBDIRS_DEST) $(DESTS) $(RAW_FILES_DEST)

$(UNCHANGED_FILE):
	touch $@

dest:
	if [ ! -e $@ ] ; then mkdir $@ ; fi

$(DESTS) :: $(TARGET)/% : src/%.wml $(LIBRARY_FILES)
	(cd src && wml $(WML_FLAGS) -DLATEMP_FILENAME=$(patsubst src/%.wml,%,$<) $(patsubst src/%,%,$<)) > $@

$(RAW_FILES_DEST) :: $(TARGET)/% : src/%
	cp -f $< $@

$(SUBDIRS_DEST) :: % : $(UNCHANGED_FILE)
	if [ ! -e $@ ] ; then mkdir $@ ; fi

# $(PACKAGES_DESTS) :: $(PACKAGES_DIR)/% : ./temp/lk-module-compiler-final/%
# 	cp -f $< $@

upload: upload_iglu

upload_iglu: all
	(cd dest && $(RSYNC) -r * hackers_il@ferrous.hexten.net:htdocs/)

.PHONY:
