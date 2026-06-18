# Static site for Coolify (Static profile / GITHUB_APP_BUILD).
# Coolify's GitHub App clones the repo and builds this Dockerfile on the worker.
# nginx serves the contents of site/ on port 80, bound to 0.0.0.0 (nginx default).
FROM nginx:alpine

# Coolify's container healthcheck shells `curl` first; the stock alpine image
# omits it, which makes the healthcheck fall back to busybox wget (IPv6-first
# on Alpine) and report the deploy unhealthy against an IPv4 listener.
RUN apk add --no-cache curl

# Static assets — index.html is served at / which satisfies the healthcheck.
COPY site/ /usr/share/nginx/html/

# TLS is terminated at the shared ALB; the request reaches the container as
# http:// — do NOT add an HTTP->HTTPS redirect here or it loops with Traefik.
EXPOSE 80
