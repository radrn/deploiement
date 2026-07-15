### Installation : 
- make init
- http://prowlarr:9696
  - créer votre compte prowlarr en accessible local
  - general / apikey -> a rentrer dans la variable d'env symfo : PROWLARR_KEY
  - créer flarsolverr dans settings / indexer -> add flaresolverr => host : http://julixid_flaresolverr:8191/
  - ajouter les indexer publique que vous voulez
  - commande symfony qui mermet d'enregistrer les indexer en bdd grace à prowlarr : app:generate-prowxlarr-indexer