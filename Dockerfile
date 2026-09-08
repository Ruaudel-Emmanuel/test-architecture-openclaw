# =============================================
# STAGE 1: Build Environment (Compiler les dépendances)
# =============================================
FROM node:20-slim AS builder
WORKDIR /app

# 1. Copier les manifestes de dépendances
COPY package.json package-lock.json ./

# 2. Installer les dépendances
RUN npm install

# 3. Copier TOUT le code source
COPY . .

# NOTE: Nous ignorons l'étape 'npm run build' et faisons confiance à l'existence du fichier.
# Si le fichier openclaw.mjs existe déjà, nous n'avons rien à faire.

# =============================================
# STAGE 2: Production Runtime (L'image finale)
# =============================================
FROM node:20-slim
WORKDIR /app

# 1. Copier les dépendances de production
COPY --from=builder /app/node_modules ./node_modules

# 2. Copier les manifestes
COPY --from=builder /app/package*.json ./

# 3. Copier le fichier de lancement manuellement
# Nous utilisons un chemin relatif ici car c'est l'endroit où le fichier réside.
COPY openclaw.mjs ./openclaw.mjs 

# 4. Configuration et Lancement
USER node
EXPOSE 18789
CMD ["node", "openclaw.mjs"]
