BUILD_DIR=build

INST_SVG=instructions/return-shipping-pack-instructions.svg
INST_PDF=$(BUILD_DIR)/return-shipping-pack-instructions.pdf

SR2017_LOANEXT_INST_MD=instructions/sr2017_loanext_instructions.md
SR2017_LOANEXT_INST_PDF=$(BUILD_DIR)/sr2017_loanext_instructions.pdf

VERSION_FILE=version

include $(VERSION_FILE)

.PHONY: all clean
SHELL=/bin/bash

all: $(INST_PDF) $(SR2017_LOANEXT_INST_PDF)

$(BUILD_DIR):
	mkdir $@

$(SR2017_LOANEXT_INST_PDF): $(SR2017_LOANEXT_INST_MD)
	pandoc -f markdown -V geometry="paper=a4paper,margin=2cm" -o $@ $<

$(INST_PDF): $(INST_SVG) $(VERSION_FILE) | $(BUILD_DIR)
	inkscape -A $@ <(sed "s/{rev}/$(VERSION)/" $<)

clean:
	rm -rf $(BUILD_DIR)
