CHARACTER=aaliyah
NIX_SETTINGS=--extra-experimental-features nix-command --extra-experimental-features flakes

# Fedora/Rubber settings
RUBBER=rubber -d -m lualatex --synctex --unsafe

check:
	nix flake check

build:
	nix ${NIX_SETTINGS} build

# Build a character using rubber (Fedora)
pdf:
	${RUBBER} ${CHARACTER}.tex

# Build all characters using rubber (Fedora)
all_pdfs:
	for f in *.tex; do [ "$$f" != "dndtemplate.sty" ] && ${RUBBER} $$f; done

build_ci:
	./scripts/run_with_log.sh nix ${NIX_SETTINGS} build

build_character:
	nix ${NIX_SETTINGS} build .#${CHARACTER}

develop:
	nix ${NIX_SETTINGS} develop

test:
	nix ${NIX_SETTINGS} build .#test

test_ci:
	./scripts/run_with_log.sh nix ${NIX_SETTINGS} build .#test

validate_test:
	./scripts/check_test_output.sh
