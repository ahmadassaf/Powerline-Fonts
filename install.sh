#!/bin/bash

# https://coderwall.com/p/zvxkcg/fix-for-brew-installing-powerline-on-mac-os-x-10-9
echo "Installing Powerline"
pip install git+git://github.com/Lokaltog/powerline

# Set source and target directories
powerline_fonts_dir=$( cd "$( dirname "$0" )" && pwd )

find_command="find \"$powerline_fonts_dir\" \( -name '*.[o,t]tf' -or -name '*.pcf.gz' \) -type f -print0"

if [[ `uname` == 'Darwin' ]]; then
  # MacOS
  font_dir="$HOME/Library/Fonts"
else
  # Linux
  font_dir="$HOME/.fonts"
  mkdir -p $font_dir
fi

# Copy all fonts to user fonts directory
eval $find_command | xargs -0 -I % cp "%" "$font_dir/"

# Reset font cache on Linux
if [[ -n `which fc-cache` ]]; then
  fc-cache -f $font_dir
fi

echo -e "All Powerline fonts installed to $font_dir .. now please change the font in the terminals need to: Inconsolata for ${red}Powerline${NC}"
