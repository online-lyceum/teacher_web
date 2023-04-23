FROM nginx AS runner
COPY nginx.conf /etc/nginx/conf.d/default.conf


FROM node:lts-alpine AS builder
WORKDIR /app
COPY app/package*.json ./
RUN npm install
COPY app/ .
RUN npm run build

FROM runner
WORKDIR /app
COPY --from=builder /app/dist ./dist
