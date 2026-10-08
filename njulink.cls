% NJU-LINK technical-report class.
% Adapted from tokenwave.cls and fairmeta.cls v1.1 (dlp@meta.com).
% Original class snapshots and their attribution are retained in upstream/.
% Preserves the original author/affiliation/abstract/metadata API.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{njulink}[2026/10/08 v1.0 NJU-LINK technical reports]
\newif\ifnjulink@chinese
\DeclareOption{chinese}{\njulink@chinesetrue}
\DeclareOption{english}{\njulink@chinesefalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[a4paper]{article}

% Open fonts distributed with TeX Live. XeLaTeX also supports Chinese text.
\RequirePackage{iftex}
\RequirePackage{amsmath,amssymb,bm}
\RequirePackage{mathpazo}
\ifPDFTeX
  \ifnjulink@chinese
    \ClassError{njulink}{Chinese mode requires XeLaTeX}
      {In Overleaf project settings, select XeLaTeX as the compiler.}
  \fi
  \RequirePackage[utf8]{inputenc}
  \RequirePackage[T1]{fontenc}
  \RequirePackage{tgpagella}
  \RequirePackage[scaled=0.94]{tgheros}
  \RequirePackage[scaled=0.92]{inconsolata}
\else
  \RequirePackage[UTF8,scheme=plain,fontset=fandol]{ctex}
  \setmainfont{texgyrepagella}[
    Extension=.otf,UprightFont=*-regular,BoldFont=*-bold,
    ItalicFont=*-italic,BoldItalicFont=*-bolditalic,Ligatures=TeX]
  \setsansfont{texgyreheros}[
    Extension=.otf,UprightFont=*-regular,BoldFont=*-bold,
    ItalicFont=*-italic,BoldItalicFont=*-bolditalic,Scale=0.94]
  \setmonofont{lmmono10-regular.otf}[Scale=MatchLowercase]
\fi

\RequirePackage[a4paper,left=25mm,right=25mm,top=23mm,bottom=23mm,
  headheight=23pt,headsep=7mm,footskip=12mm]{geometry}
\RequirePackage[table]{xcolor}
\RequirePackage{graphicx}
\RequirePackage{microtype}
\RequirePackage{etoolbox}
\RequirePackage{titlesec}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage{enumitem}
\RequirePackage{booktabs}
\RequirePackage{tabularx}
\RequirePackage{multirow}
\RequirePackage{caption}
\RequirePackage{subcaption}
\RequirePackage{float}
\RequirePackage{placeins}
\RequirePackage{tikz}
\usetikzlibrary{arrows.meta,positioning,calc}
\RequirePackage{tcolorbox}
\tcbuselibrary{skins,breakable}
\RequirePackage[authoryear,round]{natbib}
\RequirePackage{xurl}
\RequirePackage{hyperref}
\RequirePackage{bookmark}
\RequirePackage[noabbrev,nameinlink]{cleveref}

% The ink and accent colors follow the supplied NJU-LINK logo.
\definecolor{LinkNavy}{HTML}{233650}
\definecolor{LinkBlue}{HTML}{4B6FF9}
\definecolor{LinkPurple}{HTML}{7561EA}
\definecolor{LinkText}{HTML}{293342}
\definecolor{LinkMuted}{HTML}{66758B}
\definecolor{LinkRule}{HTML}{DCE2EE}
\definecolor{LinkPanel}{HTML}{F3F5FC}
\definecolor{LinkTitlePanel}{HTML}{F1F4F7}
\definecolor{LinkLavender}{HTML}{F4F1FC}
\definecolor{LinkTeal}{HTML}{368D87}
\definecolor{LinkMint}{HTML}{EFF8F5}
\definecolor{LinkSand}{HTML}{FBF5E9}

\hypersetup{unicode=true,colorlinks=true,linkcolor=LinkNavy,
  citecolor=LinkPurple,urlcolor=LinkBlue,bookmarksnumbered=true,
  pdfdisplaydoctitle=true,pdfborder={0 0 0}}
\urlstyle{same}
\pdfstringdefDisableCommands{\def\\{ }\def\thanks#1{}}

% Public metadata API. Leave a key empty to hide the corresponding field.
\def\njulink@type{Technical Report}
\def\njulink@id{}
\def\njulink@version{}
\def\njulink@subtitle{}
\def\njulink@shorttitle{NJU-LINK Technical Report}
\def\njulink@keywords{}
\def\njulink@logo{figures/njulink-logo-transparent.png}
\def\njulink@logowidth{30mm}
\pgfkeys{/njulink/.is family,/njulink,
  type/.store in=\njulink@type,
  id/.store in=\njulink@id,
  version/.store in=\njulink@version,
  subtitle/.store in=\njulink@subtitle,
  short-title/.store in=\njulink@shorttitle,
  keywords/.store in=\njulink@keywords,
  logo/.store in=\njulink@logo,
  logo-width/.store in=\njulink@logowidth}
\newcommand{\njulinksetup}[1]{\pgfkeys{/njulink,#1}}
\newcommand{\keywords}[1]{\gdef\njulink@keywords{#1}}
\newcommand{\linkbrand}{NJU-LINK}
\newcommand{\linkseparator}{\enspace\textcolor{LinkRule}{\textbar}\enspace}
\newcommand{\email}[1]{\href{mailto:#1}{\nolinkurl{#1}}}
\newcommand{\linkemph}[1]{\textcolor{LinkNavy}{\textbf{#1}}}
\newcolumntype{Y}{>{\raggedright\arraybackslash}X}

\ifnjulink@chinese
  \renewcommand{\today}{\number\year 年\number\month 月\number\day 日}
  \renewcommand{\abstractname}{摘要}
  \renewcommand{\refname}{参考文献}
  \renewcommand{\figurename}{图}
  \renewcommand{\tablename}{表}
  \def\njulink@keywordsname{关键词}
  \def\njulink@notename{研究要点}
  \def\njulink@type{研究报告}
\else
  \renewcommand{\abstractname}{Abstract}
  \renewcommand{\refname}{References}
  \renewcommand{\figurename}{Figure}
  \renewcommand{\tablename}{Table}
  \def\njulink@keywordsname{Keywords}
  \def\njulink@notename{Key takeaway}
\fi

\setlength{\parindent}{0pt}
\setlength{\parskip}{5pt plus 1pt minus 1pt}
\linespread{1.09}
\setlength{\emergencystretch}{1.5em}
\frenchspacing
\raggedbottom
\widowpenalty=10000
\clubpenalty=10000
\displaywidowpenalty=10000
\setlength{\skip\footins}{12pt}
\renewcommand{\footnoterule}{\kern-3pt
  {\color{LinkRule}\hrule width 0.28\textwidth height 0.5pt}\kern2.5pt}

\titleformat{\section}
  {\sffamily\fontsize{14}{18}\selectfont\bfseries\color{LinkNavy}}
  {\textcolor{LinkBlue}{\thesection}}{0.75em}{}
\titleformat{\subsection}
  {\sffamily\fontsize{11}{15}\selectfont\bfseries\color{LinkNavy}}
  {\textcolor{LinkMuted}{\thesubsection}}{0.65em}{}
\titleformat{\subsubsection}
  {\normalsize\bfseries\color{LinkNavy}}{\thesubsubsection}{0.6em}{}
\titleformat{\paragraph}[runin]
  {\normalsize\bfseries\color{LinkNavy}}{}{0pt}{}
\titlespacing*{\section}{0pt}{14pt plus 3pt minus 2pt}{7pt}
\titlespacing*{\subsection}{0pt}{10pt plus 2pt minus 1pt}{4pt}
\titlespacing*{\subsubsection}{0pt}{10pt}{3pt}
\titlespacing*{\paragraph}{0pt}{7pt}{0.55em}

\setlist{leftmargin=1.4em,itemsep=3pt,topsep=5pt,parsep=0pt,partopsep=0pt}
\setlist[itemize,1]{label={\small\textcolor{LinkBlue}{\textbullet}}}
\setlist[enumerate,1]{label={\textcolor{LinkBlue}{\sffamily\bfseries\arabic*.}}}
\captionsetup{font=small,labelfont={bf,color=LinkNavy},
  labelsep=period,skip=7pt,justification=justified,singlelinecheck=false}
\captionsetup[table]{position=top}
\captionsetup[subfigure]{font=footnotesize,labelfont=bf}
\renewcommand{\arraystretch}{1.22}
\setlength{\tabcolsep}{7pt}
\setlength{\textfloatsep}{12pt plus 2pt minus 2pt}
\setlength{\intextsep}{9pt plus 2pt minus 2pt}
\renewcommand{\topfraction}{0.9}
\renewcommand{\bottomfraction}{0.8}
\renewcommand{\textfraction}{0.08}
\renewcommand{\floatpagefraction}{0.8}
\setlength{\bibsep}{4pt}
\renewcommand{\bibfont}{\small}
\setcitestyle{authoryear,round,citesep={;},aysep={,},yysep={;}}

% Quiet running furniture; the first page has its own masthead.
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\includegraphics[width=20mm]{\njulink@logo}}
\fancyhead[R]{\begin{minipage}[b]{0.72\textwidth}\raggedleft
  \sffamily\fontsize{8}{10}\selectfont\color{LinkMuted}
  \njulink@shorttitle\end{minipage}}
\renewcommand{\headrulewidth}{0.35pt}
\renewcommand{\headrule}{{\color{LinkRule}\hrule
  \@height\headrulewidth\@width\headwidth\vskip-\headrulewidth}}
\fancyfoot[L]{\sffamily\fontsize{8}{10}\selectfont
  \textcolor{LinkMuted}{\linkbrand\linkseparator\njulink@type}}
\fancyfoot[R]{\sffamily\fontsize{8}{10}\selectfont
  \textcolor{LinkNavy}{\thepage}\enspace
  \textcolor{LinkMuted}{/\enspace\pageref*{LastPage}}}
\renewcommand{\footrulewidth}{0pt}
\fancypagestyle{firstpage}{\fancyhead{}\renewcommand{\headrulewidth}{0pt}}
\fancypagestyle{plain}{\fancyhead{}\renewcommand{\headrulewidth}{0pt}}

% Front-matter API retained from FAIR / TokenWave, with unexpanded storage.
% Empty optional identifiers do not leave stray superscripts or separators.
\newcommand{\authorlist}{}
\newcommand{\affiliationlist}{}
\newcommand{\contributionlist}{}
\newcommand{\metadatalist}{}
\newcommand{\abstractlist}{}
\newcommand{\titlelist}{}
\newcommand{\njulink@pdfauthors}{}
\newcommand{\njulink@sup}[1]{\ifstrempty{#1}{}{\ensuremath{^{#1}}}}
\newcommand{\authorformat}[2][]{#2\njulink@sup{#1}}
\newcommand{\affiliationformat}[2][]{\njulink@sup{#1}\,#2}
\newcommand{\contributionformat}[2][]{\njulink@sup{#1}\,#2}
\newcommand{\metadataformat}[2][]{%
  \ifstrempty{#1}{}{\textbf{#1:}\enspace}#2}
\renewcommand{\author}[2][]{%
  \ifdefempty{\authorlist}{}{\gappto\authorlist{\quad}}
  \gappto\authorlist{\authorformat[#1]{#2}}
  \ifdefempty{\njulink@pdfauthors}{}{\gappto\njulink@pdfauthors{; }}
  \gappto\njulink@pdfauthors{#2}}
\newcommand{\affiliation}[2][]{%
  \ifdefempty{\affiliationlist}{}{\gappto\affiliationlist{\quad}}
  \gappto\affiliationlist{\affiliationformat[#1]{#2}}}
\newcommand{\contribution}[2][]{%
  \ifdefempty{\contributionlist}{}{\gappto\contributionlist{\quad}}
  \gappto\contributionlist{\contributionformat[#1]{#2}}}
\newcommand{\metadata}[2][]{%
  \ifstrempty{#2}{}{%
    \ifdefempty{\metadatalist}{}{\gappto\metadatalist{\par}}
    \gappto\metadatalist{\metadataformat[#1]{#2}}}}
\renewcommand{\date}[1]{\metadata[Date]{#1}}
\newcommand{\correspondence}[1]{\metadata[Correspondence]{#1}}
\renewcommand{\abstract}[1]{\gdef\abstractlist{#1}}
\renewcommand{\title}[1]{\gdef\titlelist{#1}\gdef\@title{#1}}
\newcommand{\nm}[1]{#1}
\newcommand{\beginappendix}{%
  \appendix
  \section*{\appendixname}
  \phantomsection
  \addcontentsline{toc}{section}{\appendixname}}
\renewcommand{\bibsection}{%
  \section*{\refname}
  \phantomsection
  \addcontentsline{toc}{section}{\refname}}

% The Llama 3 v3 front-matter layout: one light-gray rounded panel, with
% the abstract following the authors and the metadata at the bottom.
% The original fairmeta.cls is retained in upstream/ for attribution.
\tcbset{njulink title panel/.style={enhanced,breakable,boxrule=0pt,
  frame hidden,arc=8pt,outer arc=8pt,colback=LinkTitlePanel,coltext=LinkText,
  boxsep=0pt,left=5mm,right=5mm,top=5mm,bottom=8mm,
  before skip=0pt,after skip=9pt,parbox=false}}
\newtcolorbox{njulinktitlebox}{njulink title panel}
\newcommand{\mymaketitle}{%
  \begin{njulinktitlebox}
  \begingroup
    \setlength{\parskip}{0pt}
    \noindent\begin{minipage}[c]{0.50\linewidth}
      \includegraphics[width=\njulink@logowidth]{\njulink@logo}
    \end{minipage}\hfill
    \begin{minipage}[c]{0.46\linewidth}\raggedleft
      {\sffamily\fontsize{8}{11}\selectfont\bfseries\color{LinkNavy}
       \MakeUppercase{\njulink@type}\par}
      \ifdefempty{\njulink@id}{}{\vspace{3pt}
        {\sffamily\fontsize{8}{10}\selectfont\color{LinkMuted}\njulink@id\par}}
    \end{minipage}\par
    \vspace{18pt}
    {\raggedright\sffamily\fontsize{24}{29}\selectfont\bfseries
      \color{LinkNavy}\titlelist\par}
    \ifdefempty{\njulink@subtitle}{}{\vspace{8pt}
      {\raggedright\sffamily\fontsize{11}{15}\selectfont
        \color{LinkMuted}\njulink@subtitle\par}}
    \ifdefempty{\authorlist}{}{\vspace{13pt}
      {\raggedright\sffamily\fontsize{10}{14}\selectfont\bfseries
        \color{LinkNavy}\authorlist\par}}
    \ifdefempty{\affiliationlist}{}{\vspace{4pt}
      {\raggedright\small\color{LinkMuted}\affiliationlist\par}}
    \ifdefempty{\contributionlist}{}{\vspace{3pt}
      {\raggedright\footnotesize\color{LinkMuted}\contributionlist\par}}
    \ifdefempty{\abstractlist}{}{\par\vspace{15pt}
      {\normalfont\normalsize\color{LinkText}\abstractlist\par}
      \ifdefempty{\njulink@keywords}{}{\par\vspace{8pt}
        {\sffamily\fontsize{8}{11}\selectfont\color{LinkMuted}
         \textbf{\njulink@keywordsname}\enspace\njulink@keywords\par}}}
    \ifdefempty{\metadatalist}{}{\vspace{18pt}
      {\raggedright\sffamily\fontsize{8}{11}\selectfont
        \color{LinkMuted}\metadatalist\par}}
    \ifdefempty{\njulink@version}{}{\vspace{3pt}
      {\sffamily\fontsize{8}{11}\selectfont\color{LinkMuted}
        \njulink@version\par}}
  \endgroup
  \end{njulinktitlebox}
}
\renewcommand{\maketitle}{%
  \if@twocolumn
    \twocolumn[\mymaketitle\vspace{6pt}]
  \else
    \mymaketitle
  \fi
  \thispagestyle{firstpage}}

\tcbset{njulink panel/.style={enhanced,breakable,boxrule=0pt,
  frame hidden,arc=8pt,outer arc=8pt,left=12pt,right=12pt,top=10pt,bottom=10pt,
  before skip=10pt,after skip=10pt,coltext=LinkText,
  parbox=false}}
\newenvironment{abstractbox}
  {\begin{tcolorbox}[njulink title panel,top=5mm,bottom=5mm,
    before skip=10pt,after skip=10pt]\normalsize}
  {\end{tcolorbox}}
\newtcolorbox{njubox}[1][]{njulink panel,
  colback=LinkLavender,
  coltitle=LinkNavy,fonttitle=\sffamily\small\bfseries,
  attach title to upper={\par\vspace{4pt}},fontupper=\small,#1}
% Compatibility with existing TokenWave and FAIR document bodies.
\newtcolorbox{twbox}[1][]{njulink panel,
  colback=LinkLavender,#1}
\colorlet{metablue}{LinkBlue}
\colorlet{metafg}{LinkText}
\colorlet{metabg}{LinkPanel}
\colorlet{twnavy}{LinkNavy}
\colorlet{twblue}{LinkBlue}
\colorlet{twviolet}{LinkPurple}
\colorlet{twpurple}{LinkPurple}
\colorlet{twfg}{LinkText}
\colorlet{twbg}{LinkPanel}
\colorlet{twgrey}{LinkMuted}

\ifnjulink@chinese
  \renewcommand{\appendixname}{附录}
  \crefname{figure}{图}{图}
  \crefname{table}{表}{表}
  \crefname{section}{节}{节}
  \crefname{subsection}{节}{节}
  \crefname{equation}{公式}{公式}
\else
  \crefname{figure}{Figure}{Figures}
  \crefname{table}{Table}{Tables}
  \crefname{section}{Section}{Sections}
  \crefname{subsection}{Section}{Sections}
  \crefname{equation}{Equation}{Equations}
\fi
\Crefname{figure}{\figurename}{\figurename}
\Crefname{table}{\tablename}{\tablename}
\ifnjulink@chinese
  \Crefname{section}{节}{节}
  \Crefname{subsection}{节}{节}
  \Crefname{equation}{公式}{公式}
\else
  \Crefname{figure}{Figure}{Figures}
  \Crefname{table}{Table}{Tables}
  \Crefname{section}{Section}{Sections}
  \Crefname{subsection}{Section}{Sections}
  \Crefname{equation}{Equation}{Equations}
\fi

\AtBeginDocument{\color{LinkText}
  \setlength{\abovedisplayskip}{7pt plus 2pt minus 2pt}
  \setlength{\belowdisplayskip}{7pt plus 2pt minus 2pt}
  \hypersetup{pdftitle={\njulink@shorttitle},pdfauthor={\njulink@pdfauthors}}}
\endinput
