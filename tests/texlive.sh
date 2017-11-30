#!/bin/bash

wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar -xzf install-tl-unx.tar.gz
cd install-tl-20*

cat << EOF >> texlive.profile
selected_scheme scheme-basic
TEXDIR /tmp/texlive
TEXMFCONFIG ~/.texlive/texmf-config
TEXMFHOME ~/texmf
TEXMFLOCAL /tmp/texlive/texmf-local
TEXMFSYSCONFIG /tmp/texlive/texmf-config
TEXMFSYSVAR /tmp/texlive/texmf-var
TEXMFVAR ~/.texlive/texmf-var
option_doc 0
option_src 0
EOF

./install-tl --profile=./texlive.profile
export PATH=/tmp/texlive/bin/x86_64-linux:$PATH

sudo env "PATH=$PATH" tlmgr update --self --all

sudo env "PATH=$PATH" tlmgr install collection-latexrecommended collection-fontsrecommended collection-langportuguese biblatex biber logreq xstring xpatch csquotes substr pdfpagediff

mkdir /tmp/texlive/texmf-local/tex/latex/biblatex-contrib
sudo ln -s $TRAVIS_BUILD_DIR /tmp/texlive/texmf-local/tex/latex/biblatex-contrib/biblatex-abnt
sudo env "PATH=$PATH" texhash

cd $TRAVIS_BUILD_DIR

