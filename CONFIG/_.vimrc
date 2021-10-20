filetype plugin indent on "Включает определение типа файла, загрузку соответсвующих ему плагинов и файлов отступов
set encoding=utf-8 "Кодировку на UTF-8
set nocompatible "Отключает обратную совместимость с vi
syntax enable "Включает подсветку синтаксиса

if empty(glob('~/.vim/autoload/plug.vim'))
	!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.vim/plugged') "Начать искать плагины в директории
"1
Plug 'ErichDonGubler/vim-sublime-monokai'
"2
Plug 'vim-airline/vim-airline'
"3
Plug 'lervag/vimtex'
call plug#end()

"1
colorscheme sublimemonokai
"2
let g:airline_powerline_fonts = 1 "Включить поддержку Powerline шрифтов
let g:airline#extensions#keymap#enaled = 0 "не показывать map
let g:airline_section_z = "\ue0a1:%l/%L Col:%c" "Кастомная графа положения курсора
let g:Powerline_sympols='unicode' "Поддержка юникода
let g:airline#extensions#xkblayout#enabled = 0 "шо це такое????????77
"3
let g:tex_flavor = 'latex' "Уточняем Tex
let g:vimtex_quickfix_mode = 0 "Отключаем автооткрытие окна Quickfix

"==Options======================
set number "relativenumber "Отображение нумерации
set wrap linebreak nolist "Перенос строк без разрыва + рендер за границами экрана
set cursorline "Подсвечивать строку к курсору

set ttimeoutlen=10 "Понижаем задержку ввода escape последовательностей
let &t_SI.="\e[5 q" "SI = режим вставки
let &t_SR.="\e[3 q" "SR = режим замены
let &t_EI.="\e[1 q" "EI = нормальный режим
"Где 1 - это мигающий прямоугольник
"2 - обычный прямоугольник
"3 - мигающее подчёркивание
"4 - просто подчёркивание
"5 - мигающая вертикальная черта
"6 - просто вертикальная черта



