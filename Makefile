REPO_NAME = KiwiSDR_PCB

# used by scgit alias
copy_to_git: clean
	@echo $(GITAPP)
	rsync -av --delete --exclude .git --exclude .DS_Store . $(GITAPP)/$(REPO_NAME)

# used by gdiff alias
gitdiff:
	diff -br --exclude=.DS_Store --exclude=.git $(GITAPP)/$(REPO_NAME) . || true
gitdiff_brief:
	diff -br --brief --exclude=.DS_Store --exclude=.git $(GITAPP)/$(REPO_NAME) . || true

.PHONY: clean
clean:
	(cd active_antenna; make clean)
	(cd active_antenna_comb; make clean)
	(cd active_antenna_opts; make clean)
	(cd active_antenna_pwr; make clean)
	(cd KiwiSDR; make clean)
