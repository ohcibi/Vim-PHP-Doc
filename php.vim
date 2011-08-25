" Vim syntax file for extending PHP to use Java-like syntaxing highlighting
" for phpDoc.
"
" Language:    php PHP 3/4/5
" Maintainer:  Andrei Nicholson <andre@neo-anime.org>
" Maintainer:  Jonathan Geiger  <jonathan@jonathan-geiger.com>
" Last Change: 2011-08-04

syntax sync fromstart

syntax match phpCommentStar contained "^\s*\*[^/]"me=e-1
syntax match phpCommentStar contained "^\s*\*$"

if !exists("php_ignore_phpdoc")
    syntax case ignore

    syntax region phpDocComment   start="/\*\*" end="\*/" keepend contains=phpCommentTitle,phpDocTags,phpTodo
    syntax region phpCommentTitle contained matchgroup=phpDocComment start="/\*\*" matchgroup=phpCommmentTitle keepend end="\.$" end="\.[ \t\r<&]"me=e-1 end="[^{]@"me=s-2,he=s-1 end="\*/"me=s-1,he=s-1 contains=phpCommentStar,phpTodo,phpDocTags containedin=phpComment

    syntax region phpDocTags  start="{@\(example\|id\|internal\|inheritdoc\|link\|source\|toc\|tutorial\)" end="}" containedin=phpComment
    syntax match  phpDocTags  "@\([a-zA-Z\-\_]\+\)\s\+\S\+" contains=phpDocParam containedin=phpComment
    syntax match  phpDocParam contained "\s\S\+"
    syntax match  phpDocTags  "@filesource" containedin=phpComment

    syntax case match
endif

if version >= 508 || !exists("did_phpdoc_syn_inits")
    if version < 508
        let did_phpdoc_syn_inits = 1
        command! -nargs=+ PhpHiLink hi link <args>
    else
        command! -nargs=+ PhpHiLink hi def link <args>
    endif

    PhpHiLink phpCommentTitle Comment
    PhpHiLink phpDocComment   Comment
    PhpHiLink phpDocTags      Special
    PhpHiLink phpDocParam     Function
    PhpHiLink phpCommentStar  Comment

    delcommand PhpHiLink
endif