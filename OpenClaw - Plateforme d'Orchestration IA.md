OpenClaw - Plateforme d'Orchestration IA

(Document de Référence Interne et Procédure de Relais)



🚀 Objectif de la Plateforme

OpenClaw est un orchestrateur de workflows avancé visant à transformer une série d'actions métier en une seule requête intelligente. Au lieu de demander à l'utilisateur de faire A, puis B, puis C, l'utilisateur fait seulement un appel au "cerveau" (OpenClaw), qui planifie et exécute la chaîne complète des tâches.



Statut Actuel : 🟢 Vivant et Opérationnel. Prochaine étape : Intégration complète d'OpenClaw Gateway (code source à venir).



🏛️ Architecture du Système (Vue d'Ensemble)

La plateforme repose sur une architecture de microservices Docker Compose, ce qui garantit l'isolation, la stabilité et la maintenabilité.



Service	Rôle	Fonctionnalité	Adresse (Communication Interne)	État

n8n\_workflow	Orchestrateur / Exécuteur	Gère les Webhooks, les API Calls, et le flux de données.	http://localhost:5678	✅ Opérationnel

ollama\_engine	Intelligence Artificielle	Fournit le moteur LLM (Llama 3) pour le raisonnement.	http://localhost:11434	✅ Opérationnel

OpenClaw Gateway	Point d'entrée	(À venir) Captera les requêtes externes et les route vers n8n/Ollama.	http://localhost:18789	⏸️ En Attente

🐳 Procédure de Démarrage (Startup Sequence)

MÉTHODE: Utiliser docker compose -f docker-compose.yml. (Rappel : Le fichier docker-compose.yml doit être la source de vérité pour ce lancement.)



1\. Nettoyage (Étape critique)

Cette commande s'assure que tous les anciens conteneurs et réseaux sont supprimés pour éviter les conflits de nom.



docker compose -f docker-compose.yml down

2\. Lancement de la Stack Complète

Cette commande va lancer et initialiser les deux services critiques (n8n et Ollama).



docker compose -f docker-compose.yml up -d

🔧 Diagnostic et Résolution de Problèmes

Problème	Message d'Erreur	Solution

Problème de connectivité	Error: pull model manifest: ... read: connection refused	Vérification du Firewall : Le port 11434 doit être ouvert en trafic sortant (egress) au niveau du réseau Cloud (OVH/AWS/etc.). Ce n'est pas un problème logiciel.

Problème de persistance	(Perte de données)	Vérification du YAML : Assurez-vous que le bloc volumes: existe bien à la fin de docker-compose.yml pour n8n\_data et ollama\_data.

Problème de nom de conteneur	Conflict. The container name "/n8n\_workflow" is already in use...	Exécuter docker rm -f n8n\_workflow pour forcer la suppression du conteneur fantôme.

🔁 Workflow de Test (Le cycle de vie)

Pour valider l'état du système, exécutez ces commandes dans l'ordre. Ce sont les commandes que vous devez utiliser pour confirmer que tout fonctionne.



Confirmation de l'état :



docker compose ps

(Résultat attendu : n8n et ollama\_engine sont Up)



Validation de l'IA (Le test ultime) :



docker exec -it ollama\_engine ollama pull llama3

docker exec -it ollama\_engine ollama run llama3 "Rédige un mini-guide de démarrage rapide pour une équipe de développeurs qui utilise une stack Docker Compose."

Si les deux commandes ci-dessus fonctionnent, la plateforme est 100% opérationnelle.

