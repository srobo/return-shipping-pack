BUILD_DIR=build
INST_SVG=instructions/return-shipping-pack-instructions.svg
INST_PDF=$(BUILD_DIR)/return-shipping-pack-instructions.pdf
VERSION_FILE=version

include $(VERSION_FILE)

.PHONY: all clean
SHELL=/bin/bash

all: $(INST_PDF)

$(BUILD_DIR):
	mkdir $@

$(INST_PDF): $(INST_SVG) $(VERSION_FILE) | $(BUILD_DIR)
	inkscape -A $@ <(sed "s/{rev}/$(VERSION)/" $<)

clean:
	rm -rf $(BUILD_DIR)
