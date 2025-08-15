IMAGE      = nginx
IMAGE_PATH = img
POD        = nginx
MANIFEST   = manifest.yaml

.PHONY: all clean build

all: clean build

clean:
	@for i in $(POD); do \
		podman pod rm -f "$$i" >/dev/null 2>&1 || true; \
	done
	@rm -rf $(IMAGE_PATH)


build:
	mkdir $(IMAGE_PATH)
	@for i in $(IMAGE); do \
		nix build ".#$$i"; \
		mv result "${IMAGE_PATH}/$$i-img"; \
		podman load < "${IMAGE_PATH}/$$i-img"; \
	done

run: all
	podman play kube $(MANIFEST)
