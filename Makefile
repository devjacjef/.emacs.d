EMACS_DIR ?= $(HOME)/.emacs.d
MIN_EMACS_RAW := https://raw.githubusercontent.com/jamescherti/minimal-emacs.d/main

update:
	@echo "Updating the Emacs configuration files."
	@git pull
	@echo "Pulling latest minimal-emacs.d init files."
	@curl -fsSL -o $(EMACS_DIR)/early-init.el $(MIN_EMACS_RAW)/early-init.el
	@curl -fsSL -o $(EMACS_DIR)/init.el $(MIN_EMACS_RAW)/init.el
	@echo "Done updating Emacs files."
