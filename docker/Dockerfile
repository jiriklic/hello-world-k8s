# Builder stage
ARG NODE_TAG
FROM node:${NODE_TAG:-20.18.0-alpine3.20} AS builder

WORKDIR /app

# Copy Next.js app source code
COPY webapp ./

# Install dependencies and build the app
RUN yarn install && yarn build

# Runner stage
FROM node:${NODE_TAG:-20.18.0-alpine3.20} AS runner

LABEL maintainer="Jiri Klic <web@jiriklic.com>"

WORKDIR /app

# Create a new user
RUN addgroup -g 1001 -S demo && adduser -S webapp -u 1001

# Copy build from builder stage
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json

# Change ownership to the new user
RUN chown -R webapp:demo /app

# Switch to the new user
USER webapp

# Expose port 8000
EXPOSE 8000

# Set the entrypoint to run the Next.js app
ENTRYPOINT ["yarn", "start"]
