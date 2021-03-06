BUILD_DIR=build

INST_SVG=instructions/return-shipping-pack-instructions.svg
INST_PDF=$(BUILD_DIR)/return-shipping-pack-instructions.pdf

RET_INST_MD=instructions/return-instructions.md
RET_INST_PDF=$(BUILD_DIR)/return-instructions.pdf

VERSION_FILE=version

include $(VERSION_FILE)

.PHONY: all clean
SHELL=/bin/bash

all: $(INST_PDF) $(RET_INST_PDF)

$(BUILD_DIR):
	mkdir $@

$(RET_INST_PDF): $(RET_INST_MD) $(VERSION_FILE) | $(BUILD_DIR)
	pandoc -f markdown -V geometry="paper=a4paper,margin=2cm" -o $@ <(cat $< <(echo -e "\n [^1]: Document revision $(VERSION)"))

$(INST_PDF): $(INST_SVG) $(VERSION_FILE) | $(BUILD_DIR)
	inkscape -A $@ <(sed "s/{rev}/$(VERSION)/" $<)

clean:
	rm -rf $(BUILD_DIR)
