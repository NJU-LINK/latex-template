% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tokenwave.cls -- TokenWave tech-report class
%
% Derived from fairmeta.cls v1.1 (FAIR pre-print style, dlp@meta.com), in
% the variant used by the Llama 3 paper (arXiv:2407.21783): logo top-left
% of the title box, title below it. The author/affiliation/metadata
% machinery and section/caption formats are kept; the brand layer
% (colours, fonts, logo, accent) is TokenWave.
%
% Compiler: pdflatex (XeLaTeX also works; see the fonts block).
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tokenwave}[2026/09/11 v1.0 TokenWave tech-report class]
\LoadClassWithOptions{article}

% Layout %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[table]{xcolor}

\RequirePackage[top=2.25cm, bottom=2.5cm, left=2.5cm, right=2.5cm, columnsep=0.65cm]{geometry}
\RequirePackage{microtype}
\RequirePackage{placeins}
\RequirePackage{hyphenat}
\RequirePackage{setspace}
\RequirePackage{parskip}
\RequirePackage[english]{babel}
\RequirePackage{etoolbox}

\ifdefined\pdftexversion
  \DisableLigatures[f]{family=sf*}
\fi

% Graphics %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{graphicx}
\RequirePackage{subcaption}

% Tables %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{booktabs}
\RequirePackage{multirow}
\RequirePackage{bm}
\newcommand{\nm}[1]{#1}

% Brand: colours %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sampled from the TokenWave logo.
%   wordmark navy  (4,19,51)     -> twnavy   (headings, title, bold)
%   wave blue      (79,90,240)   -> twblue   (links, gradient start)
%   wave violet    (104,67,238)  -> twviolet (gradient end, accents)
%   wordmark dot   (83,77,226)   -> twpurple

\RequirePackage[most]{tcolorbox}
\definecolor{twnavy}{HTML}{041333}
\definecolor{twblue}{HTML}{4F5AF0}
\definecolor{twviolet}{HTML}{6843EE}
\definecolor{twpurple}{HTML}{534DE2}
\definecolor{twfg}{HTML}{111A33}    % body ink inside the title box
\definecolor{twbg}{HTML}{F3F4FD}    % pale blue-violet wash for the title box
\definecolor{twgrey}{HTML}{5B6472}

% Backwards-compatible aliases so fairmeta content ports without edits.
\colorlet{metablue}{twblue}
\colorlet{metafg}{twfg}
\colorlet{metabg}{twbg}

% References %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{hyperref}
\RequirePackage[noabbrev,nameinlink]{cleveref}
\hypersetup{
  colorlinks,
  linkcolor=twblue,
  citecolor=twviolet,
  urlcolor=twblue
}

\RequirePackage[round,authoryear]{natbib}
\def\bibfont{\small}

% Section and caption format %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{titlesec}
\titleformat*{\paragraph}{\itshape}
\titleformat*{\section}{\Large\sffamily\bfseries\color{twnavy}}
\titleformat*{\subsection}{\large\sffamily\bfseries\color{twnavy}}
\titleformat*{\subsubsection}{\normalsize\sffamily\bfseries\color{twnavy}}
\DeclareTextFontCommand{\textbf}{\bfseries\sffamily}

\RequirePackage{caption}
\DeclareCaptionLabelSeparator{custom}{}
\DeclareCaptionFormat{custom}{{\sffamily\bfseries\color{twviolet}#1 #2} #3}
\captionsetup{singlelinecheck=false,format=custom,labelsep=custom,font=small}
\captionsetup[sub]{singlelinecheck=true,format=custom,labelsep=custom,font=small}

% Brand: fonts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fairmeta ships Meta's proprietary "Optimistic" sans. TokenWave's wordmark
% is a geometric, rounded sans; Montserrat is the closest open face in
% TeX Live and is used for all sans text (title, authors, headings, bold).
% Body text stays the article default serif, as in fairmeta.

% fairmeta uses cmvtt; it is bitmap-only under pdflatex and breaks
% microtype's font expansion, so a scalable monospace is used instead.
\RequirePackage[scaled=0.92]{inconsolata}

\ifdefined\XeTeXversion
  \RequirePackage{fontspec}
  \setmainfont{Latin Modern Roman}
  \setsansfont[Scale=0.88]{Montserrat}
\else
  \RequirePackage[T1]{fontenc}
  \RequirePackage{lmodern}   % scalable Computer Modern for the serif body
  \RequirePackage[scale=0.88,lining]{montserrat}
\fi

% Authors, affiliations, infos %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Unchanged from fairmeta: \author[n]{Name}, \affiliation[n]{Org},
% \contribution[n]{...}, \metadata[Key]{value}, \date, \correspondence.

\renewcommand\addtolist[5][]{
  \begingroup
    \if\relax#3\relax\def\sep{}\else\def\sep{#5}\fi
    \let\protect\@unexpandable@protect
    \xdef#3{\expandafter{#3}\sep #4[#1]{#2}}%
  \endgroup
}

\newcommand\authorlist{}
\newcommand\authorformat[2][]{{\sffamily \bfseries\color{twnavy} #2$^{#1}$}}
\renewcommand\author[2][]{\addtolist[#1]{#2}{\authorlist}{\authorformat}{, }}

\newcommand\affiliationlist{}
\newcommand\affiliationformat[2][]{{\normalsize $^{#1}$#2}}
\newcommand\affiliation[2][]{\addtolist[#1]{#2}{\affiliationlist}{\affiliationformat}{, }}

\newcommand\contributionlist{}
\newcommand\contributionformat[2][]{{\small $^{#1}$#2}}
\newcommand\contribution[2][]{\addtolist[#1]{#2}{\contributionlist}{\contributionformat}{, }}

\newcommand\metadatalist{}
\newcommand\metadataformat[2][]{{\small {\sffamily \bfseries\color{twnavy} #1:} #2}}
\newcommand\metadata[2][]{\addtolist[#1]{#2}{\metadatalist}{\metadataformat}{\par}}

\renewcommand{\abstract}[1]{\def\abstractlist{{\color{twfg} #1}}}
\newcommand{\email}[1]{\href{mailto:#1}{\texttt{#1}}}

\renewcommand\date[1]{\metadata[Date]{#1}}
\newcommand\correspondence[1]{\metadata[Correspondence]{#1}}

\renewcommand{\title}[1]{\newcommand{\titlelist}{{\huge\sffamily\bfseries\color{twnavy} #1}}}

\newcommand{\beginappendix}{\appendix{\huge\sffamily\color{twnavy} Appendix\par}}

% Brand: logo %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The Llama 3 class puts a 1.5cm-wide "Meta" wordmark (aspect 3.65) in the
% top-left of the title box. The full TokenWave logo (mark + wordmark,
% aspect 9.0) goes in the same place, sized so the wordmark reads at
% roughly the same cap height.

\newcommand{\twlogofile}{figures/tokenwave_logo.png}
\newcommand{\twlogowidth}{4.2cm}

% Brand: gradient accent %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A thin blue->violet bar along the left edge of the title box, echoing the
% wave. Drawn in the tcolorbox overlay so no external asset is needed.

\newcommand{\twaccentwidth}{3.5pt}

% Titlebox %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\mymaketitle}{%
  \tcbset{enhanced,frame hidden}
  \tcbset{left=0.5cm}
  \tcbset{right=0.5cm}
  \tcbset{top=1.8cm}
  \tcbset{bottom=0.8cm}
  \tcbset{arc=8pt}
  \tcbset{colback=twbg}
  \tcbset{before skip=0pt}
  \tcbset{grow to left by=1.5pt}
  \tcbset{grow to right by=1.5pt}
  \tcbset{overlay={%
    % left-edge gradient accent, clipped to the rounded frame so it
    % follows the corners instead of poking out of them
    \begin{scope}
      \clip[rounded corners=8pt] (frame.south west) rectangle (frame.north east);
      \shade[top color=twblue, bottom color=twviolet]
        (frame.north west) rectangle ([xshift=\twaccentwidth]frame.south west);
    \end{scope}
    % logo, top-left (Llama 3 placement)
    \node[anchor=north west, at=(frame.north west),
          xshift=0.5cm, yshift=-0.5cm, inner sep=0pt]
      {\includegraphics[width=\twlogowidth]{\twlogofile}};}}
  %
  \begin{tcolorbox}
    \setlength{\parindent}{0cm}
    \setlength{\parskip}{0.5cm}
    {
      \setlength{\parskip}{0cm}
      \raggedright
      \nohyphens
      %
      {
        \setstretch{1.618}
        \titlelist\par
      }
      \vskip 0.3cm
      %
      \authorlist\par
      %
      \affiliationlist\par
      %
      \contributionlist\par
    }
    \vskip 0.2cm
    %
    {
    \abstractlist\par
    }
    %
    \vskip 0.8cm
    %
    {
      \setlength{\parskip}{0cm}
      \ifdefempty{\metadatalist}{\vspace*{0.6cm}}{\metadatalist\par}
    }
  \end{tcolorbox}
  \tcbset{reset}
  \FloatBarrier
}

\if@twocolumn%
\renewcommand{\maketitle}{
\twocolumn[%
  \mymaketitle
  \vskip 0.38cm
]
}%
\else%
\renewcommand{\maketitle}{
  \mymaketitle
}%
\fi

% Callout box (extra, not in fairmeta) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newtcolorbox{twbox}[1][]{
  enhanced, frame hidden, colback=twbg, arc=6pt,
  left=8pt, right=8pt, top=6pt, bottom=6pt,
  overlay={\begin{scope}
    \clip[rounded corners=6pt] (frame.south west) rectangle (frame.north east);
    \shade[top color=twblue, bottom color=twviolet]
      (frame.north west) rectangle ([xshift=3pt]frame.south west);
  \end{scope}},
  #1
}

\endinput
