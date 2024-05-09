SHELL=/usr/bin/env bash -o errexit

.PHONY: image
image:
	build/image.sh

.PHONY: clean
clean:
	@build/clean.sh

.PHONY: deploy
deploy:
	sudo kubectl apply -f deploy-ns-o-ran.yaml

.PHONY: delete
delete:
	sudo kubectl delete deployment ns-o-ran -n ricplt

.PHONY: rebuild
rebuild: clean image
