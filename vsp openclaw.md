Ce "README" est un document de référence complet, récapitulant non seulement les commandes, mais surtout le \*\*parcours de diagnostic\*\* et l'\*\*architecture fonctionnelle\*\* de votre système. Il est idéal pour la documentation interne ou pour quiconque prenne le relais sur votre VPS.



Voici le document final, structuré de manière professionnelle.



\*\*\*



\# 🚀 README : Déploiement de l'Orchestrateur de Workflows (n8n)

\*\*Plateforme :\*\* VPS Linux (Ubuntu)

\*\*Objectif :\*\* Mettre en place une plateforme de workflows d'automatisation (n8n) et la préparer pour l'intégration avec des LLMs et OpenClaw.

\*\*Statut :\*\* 🟢 Service n8n opérationnel et validé. Le service OpenClaw est mis en pause en attente des sources de code complètes.



\*\*\*



\## 🛠️ 1. Architecture du Système (High Level)



Ce projet est structuré sur une architecture de microservices gérée par \*\*Docker Compose\*\*. Chaque fonctionnalité est un conteneur isolé, ce qui garantit une stabilité maximale et l'absence de conflits de dépendances (Node.js, Python, etc.).



| Service | Rôle | Port Exposé (Hôte) | Description | Statut |

| :--- | :--- | :--- | :--- | :--- |

| \*\*n8n\*\* | Workflow Automation | `5678` | Le moteur qui exécute les tâches (Webhooks, API calls, etc.). | \*\*✅ Opérationnel\*\* |

| \*\*OpenClaw Gateway\*\* | Passerelle API / Orchestration | `18789` | Le pont entre les services et la logique d'IA. | ⏸️ En pause (Dépend de la source code) |

| \*\*Ollama\*\* | Moteur LLM | `11434` | Fournit l'intelligence artificielle (Modèles Llama, etc.). | 🔴 À déployer |



\## ⚙️ 2. Prérequis pour le Démarrage



Avant de lancer les commandes, assurez-vous que les prérequis suivants sont en place :



1\.  \*\*Docker Engine \& Docker Compose:\*\* Doivent être installés et que votre utilisateur (`ubuntu`) fait partie du groupe `docker`.

2\.  \*\*Le Dossier de Travail :\*\* Vous devez être dans le répertoire `\~/openclaw` qui contient :

&#x20;   \*   `docker-compose.yml` (Le fichier de définition).

&#x20;   \*   `n8n\_data` (Le dossier de persistence des workflows de n8n).

3\.  \*\*Variables d'environnement (.env) :\*\* Un fichier `.env` doit être créé dans `\~/openclaw` et contenir toutes les clés secrètes (secrets, tokens, etc.) nécessaires au bon fonctionnement de n8n.



\## 🖥️ 3. Guide de Lancement (Le Flow de Commandes)



Ces commandes doivent être exécutées dans le répertoire `\~/openclaw`.



\### 🚧 Étape A : Nettoyage du Système

Exécutez cette commande pour garantir qu'aucun ancien conteneur ou réseau n'interfère avec le nouveau lancement.

```bash

docker compose down

```



\### 💡 Étape B : Lancement n8n (Le Test de Validation)

Nous lançons uniquement le service `n8n` pour confirmer que le système est stable et que la plateforme de workflow fonctionne.



```bash

\# Lance UNIQUEMENT le service n8n (en ignorant les services OpenClaw trop complexes pour le moment)

docker compose up -d n8n

```



\### 🎯 Vérification de l'accès

1\.  \*\*Vérifiez l'état :\*\*

&#x20;   ```bash

&#x20;   docker compose ps

&#x20;   ```

&#x20;   \*(Résultat attendu : Le conteneur `n8n\_workflow` doit être `Up`)\*



2\.  \*\*Accédez à l'interface :\*\*

&#x20;   \*   Ouvrez votre navigateur et accédez à `http://\[Votre IP VPS]:5678`

&#x20;   \*   Utilisez les identifiants définis dans le `.env` pour vous connecter et valider que vous accédez à votre tableau de bord n8n.



\## 🎯 4. Feuille de route pour l'avenir (Prochaine Phase)



Votre système est maintenant stable pour n8n. La prochaine étape consiste à l'intégrer à l'Intelligence Artificielle.



| Phase | Composant | Action Requise | Impact |

| :--- | :--- | :--- | :--- |

| \*\*Phase 1 (Immédiate)\*\* | \*\*Ollama\*\* | Créer et lancer le service Ollama (via un `docker-compose.yml` mis à jour). | Fournit le cerveau (le modèle LLM). |

| \*\*Phase 2 (Avancé)\*\* | \*\*OpenClaw\*\* | Obtenir le dépôt source OpenClaw et corriger le `Dockerfile` manuellement. | Permet l'orchestration des workflows complexes. |

| \*\*Phase 3 (Validation)\*\* | \*\*n8n $\\leftrightarrow$ Ollama\*\* | Créer un workflow n8n qui appelle l'API `http://ollama:11434` pour traiter une requête en temps réel. | Permet l'automatisation avec de l'IA. |



\---

\*\*\*(Fin du document)\*\*\*

