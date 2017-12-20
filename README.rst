JakskiTags
================================================================================

Simple Vim plugin for storing ctags output centrally.

How it works
--------------------------------------------------------------------------------

All tags are stored in `g:jakskitags_dir` (`~/.tags` by default), in files named
after first 16 characters of SHA256 sums from catalog path, where they were
generated. Unless `tags` local variable has been set, plugin sets it to its
global version and adds location of generated tags file.

Keybinds:

- `<Leader>tg` - generate tag file
