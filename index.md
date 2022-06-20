---
date: \today # Should be set to the date of release
lang: de-DE

documentclass: scrreport
papersize: a4
linestretch: 1.5

title: Pandoc-Vorlage für Arbeiten an der DHBW-Mosbach
subtitle: |
  Unterstützt Projektarbeiten, Studienarbeiten und Bachelorarbeiten
author: # Must always be an array for templating purposes
  - Maxi Muster
  - Max Muster
matricle-number:
  - 1234567
  - 1234568
course: MOS-TINF19X

location: Mosbach # Your location
paper-type: Bachelorarbeit T3_3300
working-period: 12 Wochen

university-location: Mosbach
degree-course: Angewandte Informatik

# Company stuff, all optional, because of Studienarbeit
company: My Cool Company
company-location: Berlin
company-logo: img/company_logo.png

# Tutors, also optional
company-tutor: Herr Müller
university-tutor: Frau Prof. Dr. Meier

abstract: | # Optional
  Dies ist ein zu kurzes Abstract.
  Das Abstract für tatsächliche Projektarbeiten sollte 200 bis 250 Wörter lang sein.
other-abstracts: # All optional, languages must be in babel-otherlangs
  english: |
    This is a similarly too short abstract, but in English.
    The abstract for actual papers should be between 200 and 250 words in length.
babel-otherlangs:
  - english # For other-abstracts, see above

colorlinks: true # Colorize links, useful for the digital version

# lot: true # Enable list of tables
# lof: true # Enable list of figures
---

\pagebreak

# Abkürzungsverzeichnis {#acronyms -}

# Einleitung

Eine Vorlage, um wissenschaftliche Arbeiten für die +dhbw in [Pandoc](https://pandoc.org) verfassen zu können.

Dabei werden die in [@DHBW.2021] beschriebenen Richtlinien nach bestem Gewissen umgesetzt.

# Verwendung

## Drone

Am einfachsten ist die Verwendung mit [Drone](https://drone.io).
Wenn Drone und Docker installiert sind, reicht folgender Befehl:

```sh
drone exec
```

Basierend auf Drone lässt sich auch alternativ zu GitHub-Actions eine Build-Automatisierung nutzen.

## Docker {#sec:usage-docker}

Um diese Vorlage zu verwenden kann das Docker-Image [`siphalor/extended-pandoc`][docker-image] verwendet werden.

Unter Linux kann folgender Befehl zum Kompilieren der PDF mit Docker verwendet werden:

```sh
docker run --rm --volume $(pwd):/data --entrypoint make siphalor/extended-pandoc
``` 

## Manuell

Alternativ können die nötigen Extensions selbst installiert werden.
Die Liste der Extensions findet sich in [der Readme des Docker-Images][docker-image].

Anschließend kann mit `make index.pdf` die PDF-Datei kompiliert werden.
Unter Windows kann sich der entsprechende Befehl aus dem `Makefile` entnommen werden.

### Windows

Im Folgenden wird die Installation unter Windows beschrieben.
Die folgenden Befehle sollten in PowerShell ausgeführt werden (alternativ [pwsh](https://github.com/powershell/powershell)).

Als Package Manager wird Scoop genutzt, da dieser einfache Installationen und Updates ohne administrative Rechte ermöglicht.
```pwsh
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex
```

Weiterhin wird `pip` benötigt um die Python-basierten Extensions zu installieren:
```pwsh
scoop install python
python -m ensurepip
```

Nun benötigen wir noch den `make` command aus den GNU coreutils.
Hier kann beispielsweise die Rust-Implementierung dieser Tools verwendet werden:
```pwsh
scoop install uutils-coreutils
```

Abschließend werden jetzt die Pandoc- und Latex-Umgebung installiert.
In den folgenden Befehlen wird [TinyTeX](https://github.com/rstudio/tinytex), eine [TeX-Live][https://tug.org/texlive/]-Distribution, verwendet.  
Anstelle von `tinytex` kann auch [MikTex](https://miktex.org/howto/install-miktex) (bei Scoop als `miktex`) verwendet werden.
Dies bietet unter anderem eine grafische Oberfläche und eine einsteigerfreundlichere Paket-Verwaltung.

```pwsh 
# texlive installation
scoop bucket add r-bucket https://github.com/cderv/r-bucket.git
scoop install tinytex
# pandoc installation
scoop install pandoc pandoc-crossref
pip install pandoc-acro pandoc-include --user
```

### Linux

Der Einfachheit halber am besten zunächst den [Homebrew](https://brew.sh/) Package Manager installieren:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Python ist in den allermeisten Linux-Distributionen vorinstalliert, eventuell ist es als `python` statt `python3` verfügbar:
```bash
python3 -m ensurepip
```

Schlussendlich können Pandoc, die nötigen Extensions und die [TeX Live][texlive] LaTeX-Umgebung installiert werden.
```bash
brew install pandoc pandoc-crossref texlive
pip install pandoc-acro pandoc-include --user
```

[docker-image]: https://hub.docker.com/r/siphalor/extended-pandoc
[texlive]: https://tug.org/texlive/

# Demo

Unterstützt werden alle typischen Markdown-Features, sowie die nativen Erweiterungen von Pandoc:

- *kursiv*, **fett**, ***beides***, ~~durchgestrichen~~, [unterstrichen]{.underline}, [Kapitälchen]{.smallcaps}
- Definitionen und Listen:

  Wort:
  : Dies ist eine Beschreibung
    über mehrere Zeilen.

  Unsortierte Listen:
  : - Eins
  - Zwei
  - Drei

  Unsortierte Listen:
  : 1. Eins
  2. Zwei
  3. Drei

- Fußnoten[^footnote-a][^footnote-b]

[^footnote-a]: Dies ist eine Fußnote.
[^footnote-b]: Dies ist eine zweite Fußnote.

- Zitation/Quellenangaben [@DHBW.2021, Abschnitt 9.1], [@DHBW.2021, S. 23]

- Latex-Ausdrücke, zum Beispiel für mathematische Ausdrücke $\sum_{i=1}^n\frac{1}{a_b}\cdot i$

- Bilder

  ![Firmen-Logo](img/company_logo.png){#fig:some-image}

- Tabellen:

  | Spalte 1 | Spalte 2 | Spalte 3 |
  | :------- | :------: | -------: |
  | A        |    B     |        C |
  : Tabellen-Beschriftung {#tbl:some-table}

- `Code` und Code-Blöcke:

  ```python
  print("Hello World");
  ```

Für weitere native Pandoc-Features, siehe [die offizielle Dokumentation](https://pandoc.org/MANUAL.html).

## Überschrift-Ebene 2

### Überschrift-Ebene 3

#### Überschrift-Ebene 4

##### Überschrift-Ebene 5

## Extensions {#sec:extensions}

Durch Extensions wird zusätzliche Funktionalität zur Verfügung gestellt:

[`pandoc-acro`](https://github.com/kprussing/pandoc-acro) --- Abkürzungen:
: Abkürzungen können in der `acronyms.yaml` definiert werden:

    ```yaml
    acronyms:
      options:
        list/heading: chapter*
        make-links: true
      dhbw:
        short: DHBW
    ```
  
    Und anschließend verwendet werden: +dhbw; [+dhbw]{.long}

[`pandoc-crossref`](https://github.com/lierdakil/pandoc-crossref) --- Referenzen:
: Referenzen für Abschnitte (@sec:extensions), Bilder (@fig:some-image) und Tabellen (@tbl:some-table).


# Literaturverzeichnis
<!-- Leave emtpy, this is where the literature goes -->

<!-- vim: set spelllang=de-DE syn=pandoc : -->
