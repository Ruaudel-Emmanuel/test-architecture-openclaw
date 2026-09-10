\# 👑 README : Système d'Orchestration OpenClaw v3.0 (Document de Maîtrise Technique)



Ce document n'est pas un simple guide de déploiement. C'est un \*\*document de preuve de concept\*\* et un \*\*manuel de maintenance\*\* qui résume le parcours complexe de résolution de problèmes et d'optimisation du système. Il prouve la maîtrise complète de l'architecture et de la pile technologique.



\## 📄 Sommaire Exécutif



\*   \*\*Objectif :\*\* Déployer une plateforme d'orchestration unifiée (OpenClaw) qui coordonne l'intelligence artificielle (Ollama) et l'exécution des workflows métier (n8n).

\*   \*\*Statut :\*\* ✅ OPÉRATIONNEL ET STABLE.

\*   \*\*Fondamental :\*\* Le système est construit sur une architecture de microservices Docker Compose.

\*   \*\*Changement Clé :\*\* Les dépendances ont été purgées et stabilisées en passant d'une gestion de \*monorepo\* complexe (pnpm) à une installation robuste et universelle (`npm`).



\---



\## 🌐 1. Architecture et Services



| Service | Rôle | Port Externe (Hôte) | Port Interne (Conteneur) | Fonctionnalité |

| :--- | :--- | :--- | :--- | :--- |

| \*\*n8n\\\_workflow\*\* | L'Exécuteur | `5678` | `5678` | Exécute les APIs et les Webhooks. |

| \*\*ollama\\\_engine\*\* | Le Cerveau IA | `11435` | `11435` | Fournit le raisonnement LLM (Llama 3). |

| \*\*OpenClaw Gateway\*\* | L'Orchestrateur | `18789` | `18789` | Le cerveau qui reçoit la requête, raisonne, et déclenche les workflows. |



\*\*Lien Critique :\*\* `openclaw\_gateway` doit impérativement appeler `ollama\_engine:11435` pour obtenir le plan d'action.



\---



\## 🔧 2. Résumé du Parcours de Maîtrise (Le Journal de Bord)



Ce système n'a pas pu être lancé du premier coup. Nous avons dû diagnostiquer et corriger 6 couches de problèmes différentes. Chaque étape résolue démontre une maîtrise avancée des outils de déploiement.



| Défi Technique | Problème Initial | Solution Implémentée | Impact |

| :--- | :--- | :--- | :--- |

| \*\*Port I/O\*\* | `failed to bind host port 11434: address already in use` | \*\*Modification de Port.\*\* On a forcé Ollama à utiliser `11435` à la fois à l'hôte et au conteneur. | Le service IA est maintenant isolable et fonctionnel. |

| \*\*Dépendances\*\* | `npm error Unsupported URL Type "workspace:": workspace:\*` | \*\*Changement de Manager.\*\* Nous avons purgé la dépendance à `pnpm` et forcé `npm` pour une compatibilité maximale. | Le build du conteneur n'échoue plus sur les dépendances. |

| \*\*Processus de Build\*\* | `pnpm:devPreinstall: Error: Cannot find module...` | \*\*Contournement du Script.\*\* Nous avons forcé le `Dockerfile` à ignorer les scripts de pré-installation pour contourner le blocage du workspace. | Le conteneur peut être construit malgré la structure interne du monorepo. |

| \*\*Syntaxe YAML\*\* | `mapping key "volumes" already defined` | \*\*Correction Structurelle.\*\* Fusion des blocs `volumes:` pour ne garder qu'une seule définition de la ressource. | Le `docker-compose.yml` est maintenant valide. |

| \*\*Logique de Container\*\* | `service "..." refers to undefined volume...` | \*\*Ajout du Volume Manquant.\*\* Déclaration explicite de `openclaw\_data` dans la section `volumes:`. | Le service sait où stocker ses données. |



\---



\## ⚙️ 3. Procédure de Lancement et de Maintenance



Ce processus est la séquence finale et la plus courte. Exécuter ces commandes garantit la stabilité.



\*\*Pour tout re-déploiement ou la première utilisation, exécutez toujours ces trois commandes dans l'ordre.\*\*



\*\*Dans le répertoire `\~/openclaw/` :\*\*



```bash

\# 1. NETTOYAGE (Détruit toutes les anciennes versions de services et réseaux)

docker compose down



\# 2. RECONSTRUCTION (Construit l'image avec le nouveau code)

docker compose build openclaw\_gateway



\# 3. LANCEMENT (Démarre la stack complète et active)

docker compose up -d

```



\### 🩹 Diagnostic de Maintenance



| Problème | Cause la plus probable | Commande de diagnostic |

| :--- | :--- | :--- |

| \*\*Service down\*\* | 1. Port bloqué (Redémarrer le VPS) 2. Code d'erreur dans le `Dockerfile` (Exécuter `docker compose build` manuellement). | `docker compose ps` |

| \*\*Code Stale\*\* | Vous n'avez pas mis à jour `openclaw.mjs` mais vous avez relancé le service. | `docker compose logs openclaw\_gateway` |

| \*\*Port Bloqué (Cache)\*\* | Un processus du système hôte bloque le port. | \*\*Redémarrer le VPS (OVH/AWS).\*\* |

