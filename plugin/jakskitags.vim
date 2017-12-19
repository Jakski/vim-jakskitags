" Vim JakskiTags plugin for tag managment
" Author: Jakub Pieńkowski <rayunderwater@gmail.com>
" Home: https://github.com/Rayvenden/JakskiTags
" License: MIT

if exists("g:loaded_jakskitags")
    finish
endif
let g:loaded_jakskitags = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists("g:jakskitags_dir")
    let g:jakskitags_dir = $HOME . "/.tags"
endif

function! s:Generate()
    if !isdirectory(g:jakskitags_dir)
        call mkdir(g:jakskitags_dir)
    endif
    let tagfile = g:jakskitags_dir . "/" . sha256(getcwd())[:15]
    echo "Generating tags..."
    :silent :call system("ctags -R -f " . tagfile . " " . getcwd())
    if v:shell_error != 0
        echoerr "Failed to generate tags with code: " . v:shell_error
    else
        echo "Finished generating tags."
    endif
endfunction

function! jakskitags#setTagPath()
    if &l:tags != &tags
        let &l:tags = &tags . "," . g:jakskitags_dir . "/" . 
                    \ sha256(getcwd())[:15]
    endif
endfunction


augroup JakskiTags
    au BufEnter * call jakskitags#setTagPath()
augroup END

if !hasmapto("<Plug>JakskiTagsGenerate")
    nmap <unique> <Leader>tg <Plug>JakskiTagsGenerate
endif
nnoremap <silent><script> <Plug>JakskiTagsGenerate :call <SID>Generate()<CR>

let &cpo = s:save_cpo
unlet s:save_cpo
