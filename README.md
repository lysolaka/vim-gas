# VIM-GAS

This vim bundle adds advanced syntax highlighting for GNU as (AT&T).

This file defines a (almost) complete syntax for GNU as assembler. 

My motivation in writing this was the lack of a complete, working syntax for this 
common assembler. 

For now the basic as directives as well as the Intel / AMD, ARM (thumb) and AVR instruction sets are included. 
Opcodes supporting a size suffix are recognized plain as well as suffixed with b/w/l/q.

> [!NOTE]
> This fork focuses on ARM, Thumb and AVR instruction sets only, the rest is removed.

## What does it look like?

![screenshot here..](https://raw.githubusercontent.com/HealsCodes/vim-gas/master/sample.png)

## Supported instructions a per version 0.16: 

- Generic memory operations 
- Systematic names for the hinting nop instructions 
- ARM (Thumb)
- AVR

You can set different highlighting for each set listed above by adding a line like this to you .vimrc: 

```vim
  hi def link gasOpcodeX86_PENT_SSE  <some_highlighting> 
```

## CPP preprocessor macros

GAS allows code to be processed by the same preprocessor used for C/C++ code. 
So directives like `#include`, `#define` etc. will be highlighted using the C 
syntax highlighter if available. 

This behavior can be turned off by setting the `gasDisablePreproc` option 
either globally in your .vimrc or on a per-buffer basis:

```vim
" globally disable preprocessor macro detection
:let g:gasDisablePreproc=1 


" disable only for this buffer 
let gasDisablePreproc=1 
```

## Installation

For [`lazy.nvim`](https://github.com/folke/lazy.nvim) use the following plugin spec:

```lua
{
    "https://github.com/lysolaka/vim-gas",
    ft = "gas",
}
```

## Usage

Add this line to the end of your file: 

```vim
/* vim: ft=gas :
*/
```

## License

BSD (3 clause) - see LICENSE for details
