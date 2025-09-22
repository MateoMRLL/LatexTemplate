%% report.cls - English version
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{custom-report}[2025/09/22 v1.0 Technical report class - Hyperref safe]

%% ========================================
%% OPTIONS
%% ========================================
\newif\if@smallfont\@smallfontfalse
\newif\if@twoside\@twosidefalse

\DeclareUnicodeCharacter{2500}{\textendash} % ─
\DeclareUnicodeCharacter{251C}{\textbar\textendash} % ├
\DeclareUnicodeCharacter{2514}{\textbackslash\textendash} % └
\DeclareUnicodeCharacter{2502}{\textbar}    % │


\DeclareOption{7pt}{\@smallfonttrue}
\DeclareOption{smallfont}{\@smallfonttrue}
\DeclareOption{twoside}{\@twosidetrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

%% ========================================
%% BASE CLASS
%% ========================================
\if@smallfont
    \if@twoside
        \LoadClass[10pt,a4paper,twoside]{article}
    \else
        \LoadClass[10pt,a4paper]{article}
    \fi
\else
    \if@twoside
        \LoadClass[11pt,a4paper,twoside]{article}
    \else
        \LoadClass[11pt,a4paper]{article}
    \fi
\fi

%% ========================================
%% ESSENTIAL PACKAGES
%% ========================================
\RequirePackage[english,french]{babel} % Keep french for hyphenation if needed
\RequirePackage{lmodern}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[left=1.5cm,right=1.5cm,top=2.5cm,bottom=3cm]{geometry}
\RequirePackage{fancyhdr,titlesec,graphicx,float,caption,subcaption,placeins}
\setlength{\headheight}{15pt}\addtolength{\topmargin}{-3pt}
\RequirePackage{mathtools,amssymb,amsmath,booktabs,enumitem}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage{tikz}
\usetikzlibrary{automata, positioning, shapes.geometric, arrows, circuits.logic.IEC, shadings, shadows}
\RequirePackage{circuitikz,karnaugh-map,minted,tcolorbox}
\tcbuselibrary{minted,skins,breakable}
\RequirePackage[acronym,toc]{glossaries}



%% ========================================
%% COLORS
%% ========================================
\definecolor{BlueC}{HTML}{0060DF}
\definecolor{BlueF}{HTML}{003EAA}
\definecolor{White}{HTML}{FFFFFF}
\definecolor{Black}{HTML}{000000}
\definecolor{Grey}{gray}{0.6}
\definecolor{LightGreen}{HTML}{E8F5E8}
\definecolor{DarkGreen}{HTML}{2E7D32}
\definecolor{LimeGreen}{HTML}{8BC34A}
\definecolor{LightCoral}{HTML}{FFCDD2}
\definecolor{DarkRed}{HTML}{D32F2F}
\definecolor{Tomato}{HTML}{FF6347}
\definecolor{LightBlue}{HTML}{E3F2FD}
\definecolor{DarkBlue}{HTML}{1976D2}

%% ========================================
%% DOCUMENT INFO
%% ========================================

%% Internal macros for report info
%% Internal macros
\newcommand{\report@title}{Report title}
\newcommand{\report@subject}{Report subject}
\newcommand{\report@supervisor}{Supervisor name}
\newcommand{\report@students}{Students}
\newcommand{\report@university}{University}
\newcommand{\report@logo}{logo.png}
\newcommand{\report@organization}{organization name}

%% User commands
\newcommand{\relogo}[1]{\renewcommand{\report@logo}{#1}}
\newcommand{\university}[1]{\renewcommand{\report@university}{#1}}
\newcommand{\reporttitle}[1]{\renewcommand{\report@title}{#1}}
\newcommand{\organization}[1]{\renewcommand{\report@organization}{#1}}
\newcommand{\subject}[1]{\renewcommand{\report@subject}{#1}}
\newcommand{\supervisor}[1]{\renewcommand{\report@supervisor}{#1}}
\newcommand{\students}[1]{\renewcommand{\report@students}{#1}}


%% ========================================
%% COVER PAGE
%% ========================================
\newcommand{\makecoverpage}{
    \begin{titlepage}
        \centering
        \includegraphics[width=0.5\textwidth]{\report@logo}\par\vspace{1cm}
        {\scshape\LARGE \university \par}
        \vspace{2.5cm}
        \rule{\linewidth}{0.2 mm} \\[0.4 cm]
        {\huge\bfseries \@title \par}
        \rule{\linewidth}{0.2 mm} \\[1.5 cm]
        \begin{minipage}{0.48\textwidth}
            \begin{flushleft} \large
                \emph{\textbf{Student(s):}}\\ \vspace{0.3cm} \report@students
            \end{flushleft}
        \end{minipage}~
        \begin{minipage}{0.48\textwidth}
            \begin{flushright} \large
                \emph{\textbf{Supervisor(s):}}\\ \vspace{0.3cm} \report@supervisor
            \end{flushright}
        \end{minipage}\\[4cm]
        \textbf{Organization:} \report@organization
        \vfill
        {\large \today\par}
    \end{titlepage}
    \clearemptydoublepage
}

%% ========================================
%% HYPERREF SAFE
%% ========================================
\AtBeginDocument{%
\hypersetup{
    linkcolor=BlueF,
    urlcolor=BlueC,
    citecolor=Grey,
    pdftitle={\report@title},
    pdfauthor={\report@students},
    pdfsubject={\report@organization},
    pdfkeywords={report, technical, LaTeX},
    unicode=true,
    bookmarksnumbered=true
}
\pdfstringdefDisableCommands{%
\def\textsc#1{#1}%
\def\textbf#1{#1}%
\def\emph#1{#1}%
\def\\{ }%
\def\@m{}%
}
}
% ==============================
%  APPENDICES HANDLING (clean)
% ==============================

\renewcommand{\thesection}{\Alph{section}}

\newcommand{\appendixsection}[1]{%
    \refstepcounter{section}%
    \section*{Appendix \thesection\quad #1}%
    \phantomsection
    \addcontentsline{toc}{section}{Appendix \thesection\texorpdfstring{\quad}{ }#1}%
    \phantomsection
    \addcontentsline{loa}{appendix}{Appendix \thesection\texorpdfstring{\quad}{ }#1}%
}

\newcommand{\listofappendices}{%
    \cleardoublepage
    \phantomsection
    \section*{List of Appendices}%
    \addcontentsline{toc}{section}{List of Appendices}%
    \begingroup
    \parskip=6pt
    \parindent=0pt
    \@starttoc{loa}%
    \endgroup
}

\newcommand{\l@appendix}[2]{%
    \par\noindent #1 \dotfill #2\par
}


%% ========================================
%% HEADER & FOOTER
%% ========================================
\pagestyle{fancy}
\fancyhf{}
\newcommand{\setupheader}{
    \IfFileExists{config/logo_petit.png}{
        \fancyhead[L]{\includegraphics[scale=0.05]{config/logo_petit.png}\hspace{0.3cm}}
    }{
        \fancyhead[L]{\textcolor{BlueF}{\textbf{\@title}}}
    }
    \fancyhead[R]{\rightmark}
    \fancyfoot[C]{\thepage}
}
\renewcommand{\sectionmark}[1]{\markright{\thesection.\ #1}}
\AtBeginDocument{\setupheader}

%% ========================================
%% OTHER COMMANDS
%% ========================================
\newcommand{\setmargins}{\newgeometry{left=1.5cm,right=1.5cm,top=2.5cm,bottom=3cm}}
\newcommand{\tableofcontentspage}{\tableofcontents\newpage}

\newcommand{\insertfigure}[4]{%
    \begin{figure}[H]
        \centering
        \includegraphics[height=#2]{#1}
        \caption{#3}
        \label{fig:#4}
    \end{figure}
}

\newcommand*\sepline{\begin{center}\rule[1ex]{.5\textwidth}{.5pt}\end{center}}
\newcommand*\sepstars{\begin{center}$\star\star\star$\end{center}}

\newcommand{\clearemptydoublepage}{%
    \newpage{\pagestyle{empty}\cleardoublepage}
}

%% ========================================
%% FIGURES / TABLES BY SECTION
%% ========================================
\makeatletter
\@addtoreset{figure}{section}
\renewcommand{\thefigure}{\thesection.\arabic{figure}}
\@addtoreset{table}{section}
\renewcommand{\thetable}{\thesection.\arabic{table}}
\makeatother

%% ========================================
%% TITLES
%% ========================================
\titleformat{\section}{\Large\bfseries\color{BlueF}}{\thesection}{1em}{}
\titleformat{\subsection}{\large\bfseries\color{BlueC}}{\thesubsection}{1em}{}
\titleformat{\subsubsection}{\normalsize\bfseries\color{Grey}}{\thesubsubsection}{1em}{}


%% ========================================
%% GLOSSARY
%% ========================================

\newcommand{\gla}[2]{%
    \ifglsentryexists{#1}%
    {\gls{#1}}% si l'entrée existe déjà, juste afficher le mot
    {%
        \newglossaryentry{#1}{name={#1},description={#2}}%
    #1 (\glsdesc{#1})% affiche mot + définition la première fois
}%
}


%% ========================================
%% MINTED CODE ENVIRONMENTS
%% ========================================
\newtcblisting{code}[2]{%
    title={#1}, listing engine=minted, minted language=#2,
    minted options={
            fontsize=\small,
            breaklines,
            autogobble,
            texcomments=false
        },
    colback=White, colframe=BlueF, coltitle=White, colbacktitle=BlueF,
    enhanced, breakable, listing only
}

\newtcblisting{shortcode}[1]{%
    listing engine=minted, minted language=#1,
    minted options={fontsize=\small, breaklines, autogobble},
    colback=White, colframe=BlueF, enhanced, breakable, listing only
}

%% ========================================
%% BEAMER-LIKE BLOCKS
%% ========================================
\newenvironment{exampleblock}[1]{%
    \tcolorbox[beamer,noparskip,breakable,
        colback=LightGreen,colframe=DarkGreen,
        colbacklower=LimeGreen!75!LightGreen,title=#1]}{\endtcolorbox}

\newenvironment{alertblock}[1]{%
    \tcolorbox[beamer,noparskip,breakable,
        colback=LightCoral,colframe=DarkRed,
        colbacklower=Tomato!75!LightCoral,title=#1]}{\endtcolorbox}

\newenvironment{block}[1]{%
    \tcolorbox[beamer,noparskip,breakable,
        colback=LightBlue,colframe=DarkBlue,
        colbacklower=DarkBlue!75!LightBlue,title=#1]}{\endtcolorbox}


%% ========================================
\AtBeginDocument{%
    \typeout{Report class loaded successfully (Hyperref safe)}
}

%% ========================================
%% LANGUAGE SETTINGS FOR ENGLISH
%% ========================================
\AtBeginDocument{%
    % Babel option already includes english/french
    \selectlanguage{english} % default language for report

    % Rename automatic titles
    \renewcommand{\contentsname}{Table of Contents}
    \renewcommand{\listfigurename}{List of Figures}
    \renewcommand{\listtablename}{List of Tables}
    \renewcommand{\appendixname}{Appendix}
    \renewcommand{\figurename}{Figure}
    \renewcommand{\tablename}{Table}
}

