# alpine
Alpine Linux with useful tools to run production-grade applications on it.

# Build with buildx

```bash
docker build \
--tag nikolastankovic/alpine:latest \
--pull \
--rm \
--no-cache \
--progress=plain \
--load \
.

docker run -it --rm nikolastankovic/alpine:latest /bin/bash
docker run --rm nikolastankovic/alpine:latest whoami
```