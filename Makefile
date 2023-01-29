# Pusat Tech Development
#
# Copyright (c) 2023 Devetek Tech. https://devetek.com. MIT License
# Repo: https://github.com/devetek/belajar-nginx

# Global variables
MSG_PREFIX="[belajar-ansible]"

# Required binaries
$(eval WHICH_DOCKER := $(strip $(shell which docker)))
docker_found = $(strip $(findstring docker, $(WHICH_DOCKER)))

$(eval WHICH_GAWK := $(strip $(shell which gawk)))
gawk_found = $(strip $(findstring gawk, $(WHICH_GAWK)))

$(eval WHICH_MKCERT := $(strip $(shell which mkcert)))
mkcert_found = $(strip $(findstring mkcert, $(WHICH_MKCERT)))

################################################################################
##@ GENERIC
################################################################################

help: .bin-validator ## Show available commands
	@echo " ____       _        _                 _   _       _"
	@echo "| __ )  ___| | __ _ (_) __ _ _ __     | \\ | | __ _(_)_ __ __  __"
	@echo "|  _ \\ / _ \\ |/ _\` || |/ _\` | '__|____|  \\| |/ _\` | | '_ \\\\ \\/ /"
	@echo "| |_) |  __/ | (_| || | (_| | | |_____| |\\  | (_| | | | | |>  <"
	@echo "|____/ \\___|_|\\__,_|/ |\\__,_|_|       |_| \\_|\\__, |_|_| |_/_/\\_\\"
	@echo "                  |__/                       |___/"
	@echo ""
	@echo "Copyright (c) $(shell date +"%Y") Devetek Tech. https://devetek.com."
	@echo "Repo: https://github.com/devetek/belajar-nginx"
	@echo ""
	@gawk 'function fix_value(value, str) { \
		padding=sprintf("%50s",""); \
		ret=gensub("([^ ]+)", "\\1"padding"\n ", "g", "  "value); \
		ret=gensub("(^|\n)(.{53}) *", "\\1\\2\033[0m"str"  \033[36m", "g", ret); \
		ret=substr(ret, 3, length(ret)-16-length(str)); \
		return ret; \
	} \
	BEGIN { \
		FS = ":.*##"; \
		printf "Use: make \033[36m<target>\033[0m\n"; \
	} /^\$$?\(?[a-zA-Z0-9_-]+\)?:.*?##/ { \
		printf "  \033[36m%-50s\033[0m %s\n", $$1, $$2 \
	} /^##@/ { \
		printf "\n\033[1m%s\033[0m\n", substr($$0, 5) \
	}' $(MAKEFILE_LIST)



################################################################################
##@ DEVELOPMENT
################################################################################
gencert: ## Generate SSL certificate manually
	@ ./scripts/cert.sh

run: .bin-validator gencert ## Run nginx playground
	@docker compose -f docker-compose.yml down --remove-orphans
	@docker compose -f docker-compose.yml up -d

ls: .bin-validator ## Show containers
	@docker compose -f docker-compose.yml ps

log: .bin-validator ## Show containers log
	@docker-compose -f docker-compose.yml logs -f

enter: .bin-validator ## Enter nginx container
	@ docker compose -f docker-compose.yml exec belajar-nginx sh

restart: .bin-validator ## Restart nginx container
	@ docker compose -f docker-compose.yml restart belajar-nginx

down: .bin-validator ## Shutdown playground
	@docker compose -f docker-compose.yml down --remove-orphans


# Hidden target, for contributors only
git-clean:
	@git branch | grep -v "main" | xargs git branch -D

.bin-validator: ## validate required binaries exist
# exit status code 126 - Command invoked cannot execute
ifneq ($(docker_found),docker)
	@echo "$(MSG_PREFIX) Install docker https://docs.docker.com/engine/install/"
	@exit 126
endif

ifneq ($(gawk_found),gawk)
	@echo "$(MSG_PREFIX) Install gawk for macOS https://formulae.brew.sh/formula/gawk"
	@echo "$(MSG_PREFIX) Install gawk for Ubuntu https://howtoinstall.co/en/gawk"
	@exit 126
endif

ifneq ($(mkcert_found),mkcert)
	@echo "$(MSG_PREFIX) Install mkcert https://github.com/FiloSottile/mkcert"
	@exit 126
endif
