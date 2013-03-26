execute pathogen#infect()
runtime! plugin/sensible.vim
set nocompatible
set scrolloff=2
set nowrap
set wildmenu
set iskeyword+=?,!
set iskeyword+="-"
set backspace=2
set background=dark
filetype plugin indent on
syntax on
set ruler
set incsearch
set ignorecase
set et
set sw=2
set smarttab
set number
noremap Y y$
set list
set lcs=tab:>>   "show tabs
set lcs+=trail:. "show trailing spaces
set pastetoggle=<F11>
noremap Q @q
set t_Co=256
colo vividchalk


function! BDD(args)
 if bufname("%") =~ "test.rb"
   call RunTest(a:args)
 elseif bufname("%") =~ ".scala"
   call RunSBTTest()
 elseif bufname("%") =~ ".feature"
   call RunCucumber()
 elseif bufname("%") =~ "spec.rb"
   call RunSpec(a:args)
 else
   echo "don't know how to BDD this file"
 end
endfunction

function! RunTest(args)
  let cursor = matchstr(a:args, '\d\+')
  if cursor
    while !exists("cmd") && cursor != 1
      if match(getline(cursor), 'def test') >= 0
        let cmd = ":! bundle exec ruby % -vv -n ". matchstr(getline(cursor), "test_[a-zA-Z_]*")
      else
        let cursor -= 1
      end
    endwhile
  end
  if !exists("cmd")
    let cmd = ":! bundle exec ruby % "
  end
  execute cmd
endfunction

function! RunSpec(args)
  if exists("b:rails_root") && filereadable(b:rails_root . "/script/spec")
    let spec = b:rails_root . "/script/spec"
  elseif exists("b:rails_root") && filereadable(b:rails_root . "/script/rails")
    let spec = "rspec"
  elseif filereadable("./bin/spec")
    let spec = "./bin/spec"
  else
    let spec = "spec"
  end
  let cmd = ":! " . spec . " % -cfn " . a:args
  execute cmd
endfunction

function! RunCucumber()
  if exists("b:rails_root") && filereadable(b:rails_root . "/script/spec")
    let cuke = b:rails_root . "/script/cucumber"
  else
    let cuke = "cucumber"
  end
  let cmd = ":! " . cuke . " --format=pretty  %"
  execute cmd
endfunction

function! RunSBTTest()
  execute ":! java -jar ~/sbt-launcher-0.5.5.jar test"
endfunction

map !s :call BDD("-l " . <C-r>=line('.')<CR>)
map !S :call BDD("")

map ;j :JSLintLight<CR>
map ;J :JSLintClear<CR>

map !b :%s/\s\+$//g<CR>

map \t :NERDTree<CR>


au BufNewFile,BufRead *.less set filetype=less

set iskeyword+=?,! "consider ? and ! to be part of words for ruby methods
" call ctags for the word under the cursor to avoid vim's regex escaping of
" method names that end in ?.  (e.g. foo? != foo\?)
function! Ctags()
  let word = expand("<cword>")
  execute ":tag " . word
endfunction
map <C-]> :call Ctags()<CR> " map to the normal ctags search binding
