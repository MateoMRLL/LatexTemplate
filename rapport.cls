%% rapport.cls - Version corrigée
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{rapport}[2025/09/21 v1.1 Classe pour rapports techniques - Hyperref safe]

%% ========================================
%% OPTIONS
%% ========================================
\newif\if@smallfont\@smallfontfalse
\newif\if@twoside\@twosidefalse

\DeclareOption{7pt}{\@smallfonttrue}
\DeclareOption{smallfont}{\@smallfonttrue}
\DeclareOption{twoside}{\@twosidetrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

%% ========================================
%% CLASSE DE BASE
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
%% PACKAGES ESSENTIELS
%% ========================================

\RequirePackage[english,french]{babel}
\RequirePackage{lmodern}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[left=1.5cm,right=1.5cm,top=2.5cm,bottom=3cm]{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{titlesec}
\setlength{\headheight}{15pt}\addtolength{\topmargin}{-3pt}
\RequirePackage{graphicx,float,caption,subcaption,placeins}
\RequirePackage{mathtools,amssymb,amsmath,booktabs,enumitem}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage{tikz}
\usetikzlibrary{automata, positioning, shapes.geometric, arrows, circuits.logic.IEC}
\RequirePackage{circuitikz,karnaugh-map,minted,tcolorbox}
\tcbuselibrary{minted,skins,breakable}
\usetikzlibrary{shadings,shadows}

%% ========================================
%% COULEURS
%% ========================================
\definecolor{Bleu_C}{HTML}{0060DF}
\definecolor{Bleu_F}{HTML}{003EAA}
\definecolor{Blanc}{HTML}{FFFFFF}
\definecolor{Noir}{HTML}{000000}
\definecolor{grey}{gray}{0.6}

\definecolor{LightGreen}{HTML}{E8F5E8}
\definecolor{DarkGreen}{HTML}{2E7D32}
\definecolor{LimeGreen}{HTML}{8BC34A}
\definecolor{LightCoral}{HTML}{FFCDD2}
\definecolor{DarkRed}{HTML}{D32F2F}
\definecolor{Tomato}{HTML}{FF6347}
\definecolor{LightBlue}{HTML}{E3F2FD}
\definecolor{DarkBlue}{HTML}{1976D2}

%% ========================================
%% INFOS DOCUMENT
%% ========================================
\newcommand{\@sujet}{Sujet du rapport}
\newcommand{\@titre}{Titre du rapport}
\newcommand{\@enseignant}{Nom de l'enseignant}
\newcommand{\@eleves}{Nom des élèves}
\newcommand{\@logo}{logo.png}
\newcommand{\@unif}{Nom de l'université}
\newcommand{\@cours}{Nom du cours}

\newcommand{\sujet}[1]{\renewcommand{\@sujet}{#1}}
\newcommand{\titre}[1]{\renewcommand{\@titre}{#1}}
\newcommand{\enseignant}[1]{\renewcommand{\@enseignant}{#1}}
\newcommand{\eleves}[1]{\renewcommand{\@eleves}{#1}}
\newcommand{\logo}[1]{\renewcommand{\@logo}{#1}}
\newcommand{\unif}[1]{\renewcommand{\@unif}{#1}}
\newcommand{\cours}[1]{\renewcommand{\@cours}{#1}}

%% ========================================
%% PAGE DE GARDE
%% ========================================
\newcommand{\fairepagedegarde}{
    \begin{titlepage}
        \centering
        \includegraphics[width=0.5\textwidth]{\@logo}\par\vspace{1cm}
        {\scshape\LARGE \@unif \par}
        \vspace{2.5cm}
        \rule{\linewidth}{0.2 mm} \\[0.4 cm]
        {\huge\bfseries \@titre \par}
        \rule{\linewidth}{0.2 mm} \\[1.5 cm]
        \begin{minipage}{0.5\textwidth}
            \begin{flushleft} \large
            \emph{\textbf{Élèves :}}\\ \vspace{0.3cm} \@eleves
            \end{flushleft}
        \end{minipage}~
        \begin{minipage}{0.4\textwidth}
            \begin{flushright} \large
            \emph{\textbf{Encadrant :}}\\ \vspace{0.3cm} \@enseignant
            \end{flushright}
        \end{minipage}\\[4cm]
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
        linkcolor=Bleu_F,
        urlcolor=Bleu_C,
        citecolor=grey,
        pdftitle={\@titre},
        pdfauthor={\@eleves},
        pdfsubject={\@cours},
        pdfkeywords={rapport, technique, LaTeX},
        unicode=true,
        bookmarksnumbered=true
    }
    % Protection contre les macros LaTeX dans PDF metadata
    \pdfstringdefDisableCommands{%
        \def\textsc#1{#1}%
        \def\textbf#1{#1}%
        \def\emph#1{#1}%
        \def\\{ }%
        \def\@m{}%
    }
}

%% ========================================
%% HEADER & FOOTER
%% ========================================
\pagestyle{fancy}
\fancyhf{}
\newcommand{\configheader}{
    \IfFileExists{illustrations/logoPolytech-petit.png}{
        \fancyhead[L]{\includegraphics[scale=0.05]{illustrations/logoPolytechPetit.png}\hspace{0.3cm}}
    }{
        \fancyhead[L]{\textcolor{Bleu_F}{\textbf{\@titre}}}
    }
    \fancyhead[R]{\rightmark}
    \fancyfoot[C]{\thepage}
}
\renewcommand{\sectionmark}[1]{\markright{\thesection.\ #1}}
\AtBeginDocument{\configheader}

%% ========================================
%% AUTRES COMMANDES
%% ========================================
\newcommand{\fairemarges}{\newgeometry{left=1.5cm,right=1.5cm,top=2.5cm,bottom=3cm}}
\newcommand{\tabledematieres}{\tableofcontents\newpage}

\newcounter{annexe}
\newcommand{\@annexeslist}{} % initialisation de la liste des annexes

\newcommand{\annexe}[1]{%
    \clearemptydoublepage
    \refstepcounter{annexe}%
    \section*{Annexe \Alph{annexe} : #1}%
    \addcontentsline{toc}{section}{Annexe \Alph{annexe} : #1}%
    % ajouter le titre à la liste des annexes
    \g@addto@macro\@annexeslist{\item Annexe \Alph{annexe} : #1}%
}

\newcommand{\listofannexes}{%
    \clearemptydoublepage
    \section*{Liste des annexes}%
    \addcontentsline{toc}{section}{Liste des annexes}%
    \begin{itemize}
        \@annexeslist
    \end{itemize}
}
\makeatother

\newcommand{\insererfigure}[4]{
    \begin{figure}[ht]
    \centering
    \includegraphics[height=#2]{#1}
    \caption{#3}
    \label{fig:#4}
    \end{figure}
}

\newcommand*\sepline{%
    \begin{center}\rule[1ex]{.5\textwidth}{.5pt}\end{center}}
\newcommand*\sepstars{%
    \begin{center}$\star\star\star$\end{center}}

\newcommand{\clearemptydoublepage}{%
    \newpage{\pagestyle{empty}\cleardoublepage}
}

%% ========================================
%% FIGURES/TABLEAUX PAR SECTION
%% ========================================
\makeatletter
\@addtoreset{figure}{section}
\renewcommand{\thefigure}{\thesection.\arabic{figure}}
\@addtoreset{table}{section}
\renewcommand{\thetable}{\thesection.\arabic{table}}
\makeatother

%% ========================================
%% TITRES
%% ========================================
\titleformat{\section}{\Large\bfseries\color{Bleu_F}}{\thesection}{1em}{}
\titleformat{\subsection}{\large\bfseries\color{Bleu_C}}{\thesubsection}{1em}{}
\titleformat{\subsubsection}{\normalsize\bfseries\color{grey}}{\thesubsubsection}{1em}{}

%% ========================================
%% ENVIRONNEMENTS CODE MINTED
%% ========================================
\newtcblisting{code}[2]{
    title={#1}, listing engine=minted, minted language=#2,
    minted options={fontsize=\small, breaklines, autogobble, numbersep=3mm, linenos},
    colback=Blanc, colframe=Bleu_F, coltitle=Blanc, colbacktitle=Bleu_F,
    enhanced, breakable, listing only
}
\newtcblisting{codecourt}[1]{
    listing engine=minted, minted language=#1,
    minted options={fontsize=\small, breaklines, autogobble},
    colback=Blanc, colframe=Bleu_F, enhanced, breakable, listing only
}

%% ========================================
%% BLOCS BEAMER
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
    \typeout{Classe rapport chargée avec succès (Hyperref safe)}
}
