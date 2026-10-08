% Compatibility entry: old documents can retain \documentclass{tokenwave}.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tokenwave}[2026/10/08 Compatibility wrapper for NJU-LINK]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{njulink}}
\ProcessOptions\relax
\LoadClass{njulink}
\endinput
