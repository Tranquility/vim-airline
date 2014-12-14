" MIT License. Copyright (c) 2013-2014 Bailey Ling.
" vim: et ts=2 sts=2 sw=2

if !exists(':Neomake')
  finish
endif

function! NeomakeStatuslineLocList()
    let errcount = 0
    let buf = bufnr('%')
    for err in getloclist(winnr())
        if err.bufnr ==# buf
            let errcount += 1
        endif
    endfor
    if errcount
        return 'Errors: '.errcount.' '
    else
        return ''
    endif
endfunction

function! airline#extensions#neomake#get_warnings()
  let errors = NeomakeStatuslineLocList()
  if strlen(errors) > 0
    return errors.(g:airline_symbols.space)
  endif
  return ''
endfunction

function! airline#extensions#neomake#init(ext)
  call airline#parts#define_function('neomake', 'airline#extensions#neomake#get_warnings')
endfunction

