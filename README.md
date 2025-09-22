# Template de rapport

Il s'agit d'un template de rapport Latex pour Polytech Nantes utilisable avec Vscode.

> Requiert un **Linux ou un WSL** (enfin "requiert", non mais très fortement recommendé pour éviter les problèmes Windows liés au "shell-escape" notamment utilisé par minted pour la coloration syntaxique de codes.)

## Installation des packages

```bash
sudo apt update
sudo apt install texlive-full
```

## Setup VSCODE

- Extension de Latex Workshop de James WU
- Rajout du bloc suivant dans les Settings (Ctrl+Shift+P Open Users Settings (JSON))

```json

 "latex-workshop.latex.tools": [
    {
      "name": "latexmk",
      "command": "latexmk",
      "args": [
        "--shell-escape",
        "-synctex=1",
        "-interaction=nonstopmode",
        "-file-line-error",
        "-pdf",
        "-outdir=%OUTDIR%",
        "%DOC%"
      ],
      "env": {}
    },
    {
      "name": "pdflatex",
      "command": "pdflatex",
      "args": [
        "--shell-escape",
        "-synctex=1",
        "-interaction=nonstopmode",
        "-file-line-error",
        "%DOC%"
      ],
      "env": {}
    },
    {
      "name": "bibtex",
      "command": "bibtex",
      "args": [
        "%DOCFILE%"
      ],
      "env": {}
    }
  ],
  "latex-workshop.latex.recipes": [
    {
      "name": "pdfl+bib+pdfl*2",
      "tools": [
        "pdflatex",
        "bibtex",
        "pdflatex",
        "pdflatex"
      ]
    },
    {
      "name": "pdflatex",
      "tools": [
        "pdflatex"
      ]
    }
  ],
  "latex-workshop.latex.recipe.default": "pdfl+bib+pdfl*2",
  "latex-workshop.formatting.latex": "latexindent",
  "latex-workshop.view.pdf.ref.autoReload": true
```

## 2 mots sur le projet

Il s'agit d'un template avec des commandes customisées. Le pdf généré donnera donc des exemples de ce que vous pouvez faire avec la classe. La classe permet de créer un "nouveau" type de document (genre report, article...) basé sur un des types de documents connus.

Pour chaque projet je vous conseille de créer un repo privé github et de toujours avoir le .gitignore bien rempli des fichiers de build. Vous pouvez aussi vous créer un repo qui contient tout les rapports. L'avantage avec ça c'est que vous pouvez écrire des rapports à plusieurs et reprendre votre rédaction de n'importe quel ordinateur.

Vous pouvez évidemment rajouter des packages, rajouter des commandes... dans le fichier .cls, parfois il faut prendre un peu de temps pour comprendre les erreurs (extension Error Lens sympa) mais ChatGPT le fait très bien.

Si vous avez un projet avec une biblio utilisez la formule : pdf latex + pdf latex + bibtex + pdf latex.
Sinon par défaut faite un pdf latex, je vous recommande de créer une formule pdf latex + pdf latex ça passe mieux à la compilation

> Evidemment la classe n'est pas parfaite, je vais surement l'améliorer avec le temps et si par hasard vous voulez apportez des modifications, n'hésitez pas à m'en faire part.

J'ai fait une mise à jour pour que ça soit en anglais. Il est tout à fait possible de "remettre" en français en modifiant les titres. Pas besoin de changer le nom des commandes etc...
