" Vim syntax file
" Language:     GNU as (AT&T) assembler for X86
" Maintainer:   Rene Koecher <info@bitspin.org>
" Last Change:  2026 Mar 14
" Version:      0.16
" Remark:       ARM, Thumb and AVR instructions only
" License:      BSD (3 clause), see LICENSE
"

if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

setlocal iskeyword +=%,.,-,_

syn case ignore

" symbols and labels
" - these need to appear at the top to get lowest precedence

syn match gasLabel      /[-_$.A-Za-z0-9]\+\s*:/
syn match gasSymbol     /\<[^; \t()]\+\>/
syn match gasSymbolRef  /\$[-_$.A-Za-z][-_$.A-Za-z0-9]*\>/
syn match gasSpecial    /\<[$.]\>/

" constants
syn region gasString         start=/"/  end=/"/ skip=/\\"/
syn match  gasCharacter      /'\(?\|\\?\)/
syn match  gasDecimalNumber  /\$\?-\?\d\+/
syn match  gasBinaryNumber   /\$\?-\?0b[01]\+/
syn match  gasOctalNumber    /\$\?-\?0\d\+/
syn match  gasHexNumber      /\$\?-\?0x\x\+/
" -- TODO: gasFloatNumber

" directives
syn keyword gasDirective  .abort .ABORT .align .balignw .balignl
syn keyword gasDirective  .bundle_align_mode .bundle_lock .bundle_unlock .bss
syn keyword gasDirective  .cfi_startproc .cfi_sections .cfi_endproc .cfi_personality
syn keyword gasDirective  .cfi_lsda .cfi_def_cfa .cfi_def_cfa_register .cfi_def_cfa_offset
syn keyword gasDirective  .cfi_adjust_cfa_offset .cfi_offset .cfi_rel_offset .cfi_register
syn keyword gasDirective  .cfi_restore .cfi_undefined .cfi_same_value .cfi_remember_state
syn keyword gasDirective  .cfi_return_column .cfi_signal_frame .cfi_window_save .cfi_escape
syn keyword gasDirective  .cfi_val_encoded_addr .data .def .desc .dim .eject
syn keyword gasDirective  .else .elseif .endef .endif .endr .equ .equiv .eqv .err
syn keyword gasDirective  .error .exitm .extern .fail .file .fill .global .globl
syn keyword gasDirective  .gnu_attribute .hidden .ident .if .incbin .include .internal
syn keyword gasDirective  .irp .irpc .lcomm .lflags .line .linkonce .list .ln .loc .loc_mark_labels
syn keyword gasDirective  .local .mri .nolist .org .p2align .p2alignw .p2alignl
syn keyword gasDirective  .popsection .previous .print .protected .psize .purgem .pushsection
syn keyword gasDirective  .reloc .rept .sbttl .scl .section .set .single .size .skip .sleb128
syn keyword gasDirective  .stabd .stabn .stabs .struct .subsection
syn keyword gasDirective  .symver .tag .text .title .type .uleb128 .val .version
syn keyword gasDirective  .vtable_entry .vtable_inherit .warning .weak .weakref


syn keyword gasDirectiveStore  .byte .hword .word .int .long .double .short .float .quad .octa
syn keyword gasDirectiveStore  .string .string8 .string16 .ascii .asciz .comm .space

syn keyword gasDirectiveMacro  .altmacro .macro .noaltmacro .endm .endmacro .func .endfunc

" local label needs to be matched *after* numerics
syn match gasLocalLabel	 /\d\{1,2\}[:fb]/

" comments etc.
syn match  gasOperator       /[+-/*=|&~<>]\|<=\|>=\|<>/
syn region gasComment        start=/\/\*/ end=/\*\//
syn region gasCommentSingle  start=/#/ end=/$/
syn region gasCommentSingle  start=/;/ end=/$/
syn region gasCommentSingle  start=/@/ end=/$/
if exists('g:gasCppComments')
        syn region gasCommentSingle start=/\/\// end=/$/
endif

" ARM specific directives
syn keyword gasDirectiveStoreARM  .2byte .4byte .8byte

syn keyword gasDirectiveARM  .arch .arch_expression .arm .asciiz .cantunwind .code .cpu .dn .qn
syn keyword gasDirectiveARM  .eabi_attribute .even .extend .ldouble .fnend .fbstart .force_thumb
syn keyword gasDirectiveARM  .fpu .handlerdata .inst .inst.n .inst.w .ltorg .lmovsp .movsp .object_arch
syn keyword gasDirectiveARM  .packed .pad .personality .personalityindex .pool .req .save .setfp .secrel32
syn keyword gasDirectiveARM  .syntax .thumb .thumb_func .thumb_set .tlsdescseq .unreq .unwind_raw .vsave

" ARM register set
" Must be defined after gasSymbol to have higher precedence
syn keyword gasRegisterARM  sp lr pc
syn match   gasRegisterARM  /\<%\?r\([0-9]\|1[0-5]\)\>/

syn keyword gasDirectiveMacroARM  .dn .dq .req .unreq .tlsdescseq

"-- Section: ARM Thumb
syn keyword gasOpcode_ARM_THUMB  adc adceq adcne adccs adchs adccc adclo
syn keyword gasOpcode_ARM_THUMB  adcmi adcpl adcvs adcvc adchi adcls
syn keyword gasOpcode_ARM_THUMB  adcge adclt adcgt adcle adcal
syn keyword gasOpcode_ARM_THUMB  add addeq addne addcs addhs addcc addlo
syn keyword gasOpcode_ARM_THUMB  addmi addpl addvs addvc addhi addls
syn keyword gasOpcode_ARM_THUMB  addge addlt addgt addle addal
syn keyword gasOpcode_ARM_THUMB  and andeq andne andcs andhs andcc andlo
syn keyword gasOpcode_ARM_THUMB  andmi andpl andvs andvc andhi andls
syn keyword gasOpcode_ARM_THUMB  andge andlt andgt andle andal
syn keyword gasOpcode_ARM_THUMB  asr asreq asrne asrcs asrhs asrcc asrlo
syn keyword gasOpcode_ARM_THUMB  asrmi asrpl asrvs asrvc asrhi asrls
syn keyword gasOpcode_ARM_THUMB  asrge asrlt asrgt asrle asral
syn keyword gasOpcode_ARM_THUMB  b beq bne bcs bhs bcc blo bmi bpl bvs
syn keyword gasOpcode_ARM_THUMB  bvc bhi bls bge blt bgt ble bal
syn keyword gasOpcode_ARM_THUMB  bl bleq blne blcs blhs blcc bllo blmi
syn keyword gasOpcode_ARM_THUMB  blpl blvs blvc blhi blls blge bllt blgt
syn keyword gasOpcode_ARM_THUMB  blle blal
syn keyword gasOpcode_ARM_THUMB  bx bxpl bxvs bxvc bxhi bxls bxge bxlt bxgt
syn keyword gasOpcode_ARM_THUMB  bxle
syn keyword gasOpcode_ARM_THUMB  blx blxeq blxne  blxcs  blxhs  blxcc
syn keyword gasOpcode_ARM_THUMB  blxlo  blxmi  blxpl  blxvs  blxvc  blxhi
syn keyword gasOpcode_ARM_THUMB  blxls  blxge  blxlt  blxgt  blxle  blxal
syn keyword gasOpcode_ARM_THUMB  bi biceq bicne biccs bichs biccc biclo
syn keyword gasOpcode_ARM_THUMB  bicmi bicpl bicvs bicvc bichi bicls
syn keyword gasOpcode_ARM_THUMB  bicge biclt bicgt bicle bical
syn keyword gasOpcode_ARM_THUMB  cmn cmneq cmnne cmncs cmnhs cmncc cmnlo
syn keyword gasOpcode_ARM_THUMB  cmnmi cmnpl cmnvs cmnvc cmnhi cmnls
syn keyword gasOpcode_ARM_THUMB  cmnge cmnlt cmngt cmnle cmnal
syn keyword gasOpcode_ARM_THUMB  cmp cmpeq cmpne cmpcs cmphs cmpcc cmplo
syn keyword gasOpcode_ARM_THUMB  cmpmi cmppl cmpvs cmpvc cmphi cmpls
syn keyword gasOpcode_ARM_THUMB  cmpge cmplt cmpgt cmple cmpal
syn keyword gasOpcode_ARM_THUMB  eor eoreq eorne eorcs eorhs eorcc eorlo
syn keyword gasOpcode_ARM_THUMB  eormi eorpl eorvs eorvc eorhi eorls
syn keyword gasOpcode_ARM_THUMB  eorge eorlt eorgt eorle eoral
syn keyword gasOpcode_ARM_THUMB  ldmia ldmiaeq ldmiane ldmiacs ldmiahs
syn keyword gasOpcode_ARM_THUMB  ldmiacc ldmialo ldmiami ldmiapl ldmiavs
syn keyword gasOpcode_ARM_THUMB  ldmiavc ldmiahi ldmials ldmiage ldmialt
syn keyword gasOpcode_ARM_THUMB  ldmiagt ldmiale ldmiaal
syn keyword gasOpcode_ARM_THUMB  ldr ldreq ldrne ldrcs ldrhs ldrcc ldrlo
syn keyword gasOpcode_ARM_THUMB  ldrmi ldrpl ldrvs ldrvc ldrhi ldrls
syn keyword gasOpcode_ARM_THUMB  ldrge ldrlt ldrgt ldrle ldral
syn keyword gasOpcode_ARM_THUMB  ldrb ldrbeq ldrbne ldrbcs ldrbhs ldrbcc
syn keyword gasOpcode_ARM_THUMB  ldrblo ldrbmi ldrbpl ldrbvs ldrbvc
syn keyword gasOpcode_ARM_THUMB  ldrbhi ldrbls ldrbge ldrblt ldrbgt
syn keyword gasOpcode_ARM_THUMB  ldrble ldrbal
syn keyword gasOpcode_ARM_THUMB  ldrh ldrheq ldrhne ldrhcs ldrhhs ldrhcc
syn keyword gasOpcode_ARM_THUMB  ldrhlo ldrhmi ldrhpl ldrhvs ldrhvc
syn keyword gasOpcode_ARM_THUMB  ldrhhi ldrhls ldrhge ldrhlt ldrhgt
syn keyword gasOpcode_ARM_THUMB  ldrhle ldrhal
syn keyword gasOpcode_ARM_THUMB  lsl lsleq lslne lslcs lslhs lslcc lsllo
syn keyword gasOpcode_ARM_THUMB  lslmi lslpl lslvs lslvc lslhi lslls
syn keyword gasOpcode_ARM_THUMB  lslge lsllt lslgt lslle lslal
syn keyword gasOpcode_ARM_THUMB  ldsb ldsbeq ldsbne ldsbcs ldsbhs ldsbcc
syn keyword gasOpcode_ARM_THUMB  ldsblo ldsbmi ldsbpl ldsbvs ldsbvc
syn keyword gasOpcode_ARM_THUMB  ldsbhi ldsbls ldsbge ldsblt ldsbgt
syn keyword gasOpcode_ARM_THUMB  ldsble ldsbal
syn keyword gasOpcode_ARM_THUMB  ldsd ldsheq ldshne ldshcs ldshhs ldshcc
syn keyword gasOpcode_ARM_THUMB  ldshlo ldshmi ldshpl ldshvs ldshvc
syn keyword gasOpcode_ARM_THUMB  ldshhi ldshls ldshge ldshlt ldshgt
syn keyword gasOpcode_ARM_THUMB  ldshle ldshal
syn keyword gasOpcode_ARM_THUMB  mov moveq movne movcs movhs movcc movlo
syn keyword gasOpcode_ARM_THUMB  movmi movpl movvs movvc movhi movls
syn keyword gasOpcode_ARM_THUMB  movge movlt movgt movle moval
syn keyword gasOpcode_ARM_THUMB  mul muleq mulne mulcs mulhs mulcc mullo
syn keyword gasOpcode_ARM_THUMB  mulmi mulpl mulvs mulvc mulhi mulls
syn keyword gasOpcode_ARM_THUMB  mulge mullt mulgt mulle mulal
syn keyword gasOpcode_ARM_THUMB  mvn mvneq mvnne mvncs mvnhs mvncc mvnlo
syn keyword gasOpcode_ARM_THUMB  mvnmi mvnpl mvnvs mvnvc mvnhi mvnls
syn keyword gasOpcode_ARM_THUMB  mvnge mvnlt mvngt mvnle mvnal
syn keyword gasOpcode_ARM_THUMB  neg negeq negne negcs neghs negcc neglo
syn keyword gasOpcode_ARM_THUMB  negmi negpl negvs negvc neghi negls
syn keyword gasOpcode_ARM_THUMB  negge neglt neggt negle negal
syn keyword gasOpcode_ARM_THUMB  or orreq orrne orrcs orrhs orrcc orrlo
syn keyword gasOpcode_ARM_THUMB  orrmi orrpl orrvs orrvc orrhi orrls
syn keyword gasOpcode_ARM_THUMB  orrge orrlt orrgt orrle orral
syn keyword gasOpcode_ARM_THUMB  pop popeq popne popcs pophs popcc poplo
syn keyword gasOpcode_ARM_THUMB  popmi poppl popvs popvc pophi popls
syn keyword gasOpcode_ARM_THUMB  popge poplt popgt pople popal
syn keyword gasOpcode_ARM_THUMB  push pusheq pushne pushcs pushhs pushcc
syn keyword gasOpcode_ARM_THUMB  pushlo pushmi pushpl pushvs pushvc
syn keyword gasOpcode_ARM_THUMB  pushhi pushls pushge pushlt pushgt
syn keyword gasOpcode_ARM_THUMB  pushle pushal
syn keyword gasOpcode_ARM_THUMB  ror roreq rorne rorcs rorhs rorcc rorlo
syn keyword gasOpcode_ARM_THUMB  rormi rorpl rorvs rorvc rorhi rorls
syn keyword gasOpcode_ARM_THUMB  rorge rorlt rorgt rorle roral
syn keyword gasOpcode_ARM_THUMB  sb sbceq sbcne sbccs sbchs sbccc sbclo
syn keyword gasOpcode_ARM_THUMB  sbcmi sbcpl sbcvs sbcvc sbchi sbcls
syn keyword gasOpcode_ARM_THUMB  sbcge sbclt sbcgt sbcle sbcal
syn keyword gasOpcode_ARM_THUMB  stmia stmiaeq stmiane stmiacs stmiahs
syn keyword gasOpcode_ARM_THUMB  stmiacc stmialo stmiami stmiapl stmiavs
syn keyword gasOpcode_ARM_THUMB  stmiavc stmiahi stmials stmiage stmialt
syn keyword gasOpcode_ARM_THUMB  stmiagt stmiale stmiaal
syn keyword gasOpcode_ARM_THUMB  str streq strne strcs strhs strcc strlo
syn keyword gasOpcode_ARM_THUMB  strmi strpl strvs strvc strhi strls
syn keyword gasOpcode_ARM_THUMB  strge strlt strgt strle stral
syn keyword gasOpcode_ARM_THUMB  strb strbeq strbne strbcs strbhs strbcc
syn keyword gasOpcode_ARM_THUMB  strblo strbmi strbpl strbvs strbvc
syn keyword gasOpcode_ARM_THUMB  strbhi strbls strbge strblt strbgt
syn keyword gasOpcode_ARM_THUMB  strble strbal
syn keyword gasOpcode_ARM_THUMB  strh strheq strhne strhcs strhhs strhcc
syn keyword gasOpcode_ARM_THUMB  strhlo strhmi strhpl strhvs strhvc
syn keyword gasOpcode_ARM_THUMB  strhhi strhls strhge strhlt strhgt
syn keyword gasOpcode_ARM_THUMB  strhle strhal
syn keyword gasOpcode_ARM_THUMB  swi swieq swine swics swihs swicc swilo
syn keyword gasOpcode_ARM_THUMB  swimi swipl swivs swivc swihi swils
syn keyword gasOpcode_ARM_THUMB  swige swilt swigt swile swial
syn keyword gasOpcode_ARM_THUMB  sub subeq subne subcs subhs subcc sublo
syn keyword gasOpcode_ARM_THUMB  submi subpl subvs subvc subhi subls
syn keyword gasOpcode_ARM_THUMB  subge sublt subgt suble subal
syn keyword gasOpcode_ARM_THUMB  tst tsteq tstne tstcs tsths tstcc tstlo
syn keyword gasOpcode_ARM_THUMB  tstmi tstpl tstvs tstvc tsthi tstls
syn keyword gasOpcode_ARM_THUMB  tstge tstlt tstgt tstle tstal

"-- Section: AVR
syn keyword gasOpcode_AVR  adc add adiw and andi asr
syn keyword gasOpcode_AVR  bclr bld brbc brbs brcc brcs break breq brge
syn keyword gasOpcode_AVR  brhc brhs brid brie brlo brlt brmi brne brpl
syn keyword gasOpcode_AVR  brsh brtc brts brvc brvs bset bst
syn keyword gasOpcode_AVR  call cbi cbr clc clh cli cln clr cls clt clv
syn keyword gasOpcode_AVR  clz com cp cpc cpi cpse dec des eicall eijmp
syn keyword gasOpcode_AVR  elpm eor fmul fmuls fmulsu icall ijmp in inc
syn keyword gasOpcode_AVR  jmp lac las lat ld ldd ldi lds lpm lsl lsr
syn keyword gasOpcode_AVR  mov movw mul muls mulsu neg nop or ori out
syn keyword gasOpcode_AVR  pop push rcall ret reti rjmp rol ror sbc sbci
syn keyword gasOpcode_AVR  sbi sbic sbis sbiw sbr sbrc sbrs sec seh sei
syn keyword gasOpcode_AVR  sen ser ses set sev sez sleep spm st std sts
syn keyword gasOpcode_AVR  sub subi swap tst wdr xch


" links
hi def link gasDirectiveARM       gasDirective
hi def link gasRegisterARM        gasRegister
hi def link gasDirectiveMacroARM  gasDirectiveMacro
hi def link gasDirectiveStoreARM  gasDirectiveStore

hi def link gasOpcode_ARM_THUMB   gasOpcode
hi def link gasOpcode_AVR         gasOpcode

" link to defaults
hi def link gasDirective       Preproc
hi def link gasDirectiveStore  Type
hi def link gasDirectiveMacro  Macro
hi def link gasRegister        Identifier
hi def link gasString          String
hi def link gasCharacter       Character
hi def link gasBinaryNumber    Constant
hi def link gasOctalNumber     Constant
hi def link gasHexNumber       Constant
hi def link gasDecimalNumber   Constant
hi def link gasSymbol          Function
hi def link gasSymbolRef       Special
hi def link gasSpecial         Special
hi def link gasLabel           Function
hi def link gasLocalLabel      Label
hi def link gasOperator        Operator
hi def link gasOpcode          Keyword
hi def link gasComment         Comment
hi def link gasCommentSingle   Comment

" support CPP preprocessor tags
if !exists('g:gasDisablePreproc') && !exists('b:gasDisablePreproc')
	syn case match

	syn include @cPP syntax/c.vim
	syn match   cPPLineCont "\\$" contained

	syn region  cPPPreProc start=/^\s*#\s*\(if\|else\|endif\|define\|include\)/ end=/$/ contains=@cPP,cPPLineCont
endif

" finishing touches
let b:current_syntax = "gas"

syn sync ccomment
syn sync linebreaks=1

" vim: ts=8 sw=8 :
