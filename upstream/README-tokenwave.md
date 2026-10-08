# TokenWave tech-report template

A LaTeX class for TokenWave technical reports, derived from `fairmeta.cls`,
the FAIR pre-print class. The title-box layout follows the variant used by
the Llama 3 paper ([arXiv:2407.21783](https://arxiv.org/abs/2407.21783)):
logo top-left, title beneath it, abstract and metadata inside the box. The
front-matter API is the original's; the brand layer is TokenWave.

## Files

| File | Purpose |
| --- | --- |
| `main.tex` | Blank paper skeleton. Edit this. |
| `tokenwave.cls` | The class. Title box, author/affiliation macros, headings, captions, colours, fonts, logo. |
| `fairmeta_llama3_original.cls` | Unmodified class from the Llama 3 source (arXiv:2407.21783). Not used by the build. |
| `fairmeta_original.cls` | Unmodified class from arXiv:2607.25970, the bottom-right-logo variant. Not used by the build. |
| `assets/plainnat.bst` | The paper's bibliography style (plainnat with bare `\url{}` in the URL field). |
| `figures/tokenwave_logo.png` | Full mark + wordmark, transparent. Used in the title box. |
| `figures/tokenwave_mark.png` | Wave mark only, transparent. |
| `figures/tokenwave_wordmark.png` | Wordmark only, transparent. |

## Build

```
pdflatex main && bibtex main && pdflatex main && pdflatex main
```

Verified locally with pdfTeX (TeX Live 2021/2022). The arXiv:2607.25970
paper (125 pages) compiles under this class with only its
`\documentclass` line changed.
XeLaTeX also works; the class switches to `fontspec` automatically.

## Front-matter API (same as fairmeta)

```latex
\title{...}
\author[1,2]{First Author}        % one call per author, in order
\author[1]{Second Author}
\affiliation[1]{TokenWave AI}
\affiliation[2]{Affiliation Two}
\contribution[*]{Equal contribution}   % optional
\abstract{...}                     % rendered inside the title box
\correspondence{Name at \email{x@y}}
\date{...}                         % a metadata line, not the LaTeX date
\metadata[Website]{\url{...}}      % any extra key/value lines
```

`\maketitle` draws the box. `\beginappendix` switches to lettered appendix
sections with an "Appendix" heading.

## What changed from fairmeta

| Element | fairmeta | tokenwave |
| --- | --- | --- |
| Link colour | Meta blue `#0064E0` | wave blue `#4F5AF0`; citations wave violet `#6843EE` |
| Title-box tint | `#F1F4F7` (cool grey) | `#F3F4FD` (pale blue-violet) |
| Title, authors, headings | sans, black | Montserrat, navy `#041333` |
| Sans font | Optimistic (Meta proprietary TTF) | Montserrat (TeX Live) |
| Serif body | class default (CM) | Latin Modern (scalable CM) |
| Monospace | `cmvtt` | Inconsolata (`cmvtt` is bitmap-only and breaks microtype under pdflatex) |
| Logo | 1.5cm "Meta" wordmark, top-left of box | 4.2cm TokenWave mark + wordmark, same corner |
| Accent | none | blue-to-violet gradient bar down the left edge of the title box |
| Caption label | sans bold, black | sans bold, violet |
| Extra | | `twbox` callout environment with the same accent bar |
| babel | `[russian, latin, english]` | `[english]` (russian/latin are not installed on every TeX Live) |
| `nicematrix` | required | dropped (not used by the paper body; load it yourself if needed) |

Colour aliases `metablue`, `metafg`, `metabg` still resolve, so content
that names them ports unchanged.

## Notes

- `\textbf` switches to the sans (Montserrat), as in the original class.
- Paragraph headings are italic by default; `main.tex` overrides them to
  bold sans, matching the source paper's own preamble.
- The logo is a transparent PNG (2023 px wide). If a vector logo becomes
  available, drop it in as `figures/tokenwave_logo.pdf` and change
  `\twlogofile` in the class. `\twlogowidth` sets its width (4.2cm).
