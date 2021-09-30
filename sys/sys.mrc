;Aqui é onde ficarão seus Remotes, cuidado com o que for adicionar,
;pode causar conflito com o script.
alias goradio run http://migre.me/2qSFs
alias nic { nick HP|DBZ | ns identify hpdbz4242 }
CTCP *:*:*: {
  if ($1 == GETIP) { ctcp $nick IPRADIO 68.168.98.187:3552 }
  halt
}
alias inicia_duelo {
  if ($readini(hp.ini,$1,nick) == $null) { notice $nick 1,1 15,15 0,1 $1 não cadastrado 15,15 1,1  | halt } 
  if ($readini(hp.ini,$2,nick) == $null) { notice $nick 1,1 15,15 0,1 $2 não cadastrado 15,15 1,1  | halt } 
  if ($readini(hp.ini,$3,nick) == $null) { notice $nick 1,1 15,15 0,1 $3 não cadastrado 15,15 1,1  | halt } 
  var %cor1 = $replace($readini(hp.ini,$1,cas),grifinória,04,sonserina,09,lufa-lufa,08,corvinal,11)
  var %cor2 = $replace($readini(hp.ini,$2,cas),grifinória,04,sonserina,09,lufa-lufa,08,corvinal,11)
  var %cor3 = $replace($readini(hp.ini,$3,cas),grifinória,04,sonserina,09,lufa-lufa,08,corvinal,11)
  var %local = $read(duelo\local.txt)
  var %tempo = $read(duelo\tempo.txt)
  cx_ch # Iniciando Duelo no15 $chan
  cx_ch # Bruxo 115: %cor1 $+ $1 14( $+ %cor1 $+ $readini(hp.ini,$1,cas) $+ 14) 0Magia15: %cor1 $+ $replace($bytes($readini(hp.ini,$1,mag),db),$chr(44),$chr(46)) 0Nível15: %cor1 $+ $check_nivel($readini(hp.ini,$1,mag))
  cx_ch # Bruxo 215: %cor2 $+ $2 14( $+ %cor2 $+ $readini(hp.ini,$2,cas) $+ 14) 0Magia15: %cor2 $+ $replace($bytes($readini(hp.ini,$2,mag),db),$chr(44),$chr(46)) 0Nível15: %cor2 $+ $check_nivel($readini(hp.ini,$2,mag))
  cx_ch # Narrador15: %cor3 $+ $3 14( $+ %cor3 $+ $readini(hp.ini,$3,cas) $+ 14)
  cx_ch # Local15: %local 14(15 $+ %tempo $+ 14)
  cx_ch # Ataque em no máximo 1550 minutos. Usem 15/notice $3 seu ataque
}
alias mostra_new {
  var %ra = $ini(hpnews.ini,0)
  var %rb = $rand(1,%ra)
  var %rc = $ini(hpnews.ini,%rb)
  if ($1 != $null) { var %rc = $1 }
  var %new = $readini(hpnews.ini,%rc,new)
  if (%new == $null) { halt }
  cx_hp 15Hogwarts14/11News 1,14 %rc 0,01 $wrap(%new, fixedsys, 9, $calc($width(a, fixedsys, 9) * 240), 1) $+ 15... 14,15 14,01 $readini(hpnews.ini,%rc,data)
  halt
}
alias quote_hp {
  var %ra = $ini(quote.ini,0)
  var %rb = $rand(1,%ra)
  var %rc = $ini(quote.ini,%rb)
  cx_hp 15Hogwarts14/11Quotes 1,14 %rc 0,01 $readini(quote.ini,%rc,quo) 14,15 14,01 $readini(quote.ini,%rc,data)
  halt
}
alias treino_feiti {
  var %feit = $readini(hp.ini,$1,nftr)
  var %fnom = $readini(magias.ini,%feit,nome)
  var %dias = $readini(hp.ini,$1,dias)
  writeini hp.ini $1 datf $date
  writeini hp.ini $1 nfdi $calc(1 + $readini(hp.ini,$1,nfdi))
  writeini hp.ini $1 tempf não
  var %ndtf = $readini(hp.ini,$1,nfdi)
  var %tre = $readini(magias.ini,%feit,dias)
  if (%ndtf != %tre) { 
    msg $1 1,1 15,15 0,1 Seu treino de feitiço foi finalizado. Foi seu15 %ndtf $+ º Treino 0para aprender o feitiço15 %fnom 15,15 1,1 
  }
  if (%ndtf == %tre) {
    writeini hp.ini $1 nfdata $date
    if ($readini(hp.ini,$1,habil) == $null) { writeini hp.ini $1 habil %fnom }
    else { writeini hp.ini $1 habil $readini(hp.ini,$1,habil) $+ , $+ %fnom }
    msg $1 1,1 15,15 0,1 Você finalizou o treino e acaba de aprender o Feitiço15 %fnom 15,15 1,1 
    remini hp.ini $1 nftr
    remini hp.ini $1 tempf
    remini hp.ini $1 nfon
  }
}
alias feitic_hp {
  cx_1
  inc_m Níveis de Feitiços
  inc_cx 1-
  inc_cx Você encontrará feitiços nos seguintes níveis15:
  inc_cx 1-
  inc_cx 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 28 29 30 31 33 34 35 36 37 38 39 40
  inc_cx 1-
  inc_cx Apenas nos níveis %ncor $+ 27 0e %ncor $+ 32 0não há feitiço para ser aprendido.
  inc_cx Para ver os feitiços de um nível, digite %ncor $+ !15Nível <núm>
  cx_2
}
alias listar_niv {
  var %x1 = 1
  var %x2 = $ini(magias.ini,0)
  while (%x1 <= %x2) {
    var %f = $ini(magias.ini,%x1)
    var %nivl = $readini(magias.ini,%f,nivel)
    if (%nivl == $1) { 
      if (%ftt == $null) { var %ftt = $readini(magias.ini,%f,nome) }
      else { var %ftt = %ftt $+ , $+ $readini(magias.ini,%f,nome) }
    }
    inc %x1
  }
  var %ftt = $sorttok(%ftt,44,a)
  cx_1
  inc_m Níveis de Feitiços
  inc_cx 1-
  inc_cx Os Feitiços de nível %ncor $+ $1 $+ 15:
  inc_cx 1-
  inc_cx %ftt
  inc_cx 1-
  inc_m Para ver as infos de algum feitiço digite:
  inc_m %ncor $+ !15Feitiço <nome do feitiço>
  inc_cx 1-
  inc_m Para aprender um feitiço digite:
  inc_m %ncor $+ !15Aprender <nome do feitiço>   
  cx_2
}
alias mostra_feiticos {
  if ($readini(hp.ini,$1,habil) == $null) { cx_1 | inc_m $1 ainda não aprendeu nenhum feitiço. | cx_2 | halt }
  var %feitiços = $replace($readini(hp.ini,$1,habil),$chr(32),$chr(46))
  var %x2 = $numtok(%feitiços,44)
  var %x1 = 1
  while (%x1 <= %x2) {
    var %fet = $gettok(%feitiços,%x1,44)
    var %nfe = $readini(magias.ini,%fet,nivel)
    if (%¬' == $null) { var %¬' = %nfe %fet }
    else { var %¬' = %¬' $+ , $+ %nfe %fet }
    inc %x1
  }
  var %¬' = $sorttok(%¬',44,n)
  var %x1 = 1
  var %x2 = $numtok(%¬',44)
  cx_1
  inc_m Feitiços $1
  inc_m %ncor $+ ¯¯¯¯¯¯¯¯ $str($chr(175),$len($1))
  inc_cx 0,14 Nome                                        0,1 0,14 Nível      0,1
  inc_cx 1-
  while (%x1 <= %x2) {
    var %fet = $gettok(%¬',%x1,44)
    inc_cx   $+ %ncor $+ $replace($gettok(%fet,2,32),$chr(46),$chr(32)) $+ $str($chr(160),$calc(45 - $len($gettok(%fet,2,32)))) $gettok(%fet,1,32)
    inc %x1  
  }
  cx_2
}
alias calc_dano {
  var %nic = $readini(hp.ini,%s3,mag)
  var %1p = $int($calc(($readini(hp.ini,%s3,mag) * 2) / 100))
  var %cal = $int($calc((($calc(%s1 * %1p) + %s2) / %nic) * 100)) $+ % 
  cx_ch # Dano 7-> 0Após ataque,7 $readini(hp.ini,%s3,nick) 0sofreu perda de7 %cal 0de HP
  unset %s1
  unset %s2
  unset %s3
}
alias din_x {
  var %nuq = $1
  var %gal = 0
  var %sic = 0
  while (%nuq >= 29) {
    var %nuq = $calc(%nuq - 29)
    var %sic = $calc(%sic + 1)
  }
  while (%sic >= 17) {
    var %sic = $calc(%sic - 17)
    var %gal = $calc(%gal + 1)
  }
  return 08 $+ %gal $+ g15 %sic $+ s07 %nuq $+ n
}
alias casa_top {
  unset %top.cas1
  unset %top.cas2
  unset %top.cas3
  var %r1 = 1
  set %n.alunos 0
  while (%r1 <= $ini(hp.ini,0)) {
    if ($readini(hp.ini,$ini(hp.ini,%r1),cas) == $1) {
      inc %n.alunos
      if ($readini(hp.ini,$ini(hp.ini,%r1),pts) != $null) {
        if (%a¬ != $null) { var %a¬ = %a¬ $+ , $+ $readini(hp.ini,$ini(hp.ini,%r1),pts) $ini(hp.ini,%r1) }
        else { var %a¬ = $readini(hp.ini,$ini(hp.ini,%r1),pts) $ini(hp.ini,%r1) }
      }
      if (%v¬ != $null) { var %v¬ = %v¬ $+ , $+ $readini(hp.ini,$ini(hp.ini,%r1),vit) $ini(hp.ini,%r1) }
      else { var %v¬ = $readini(hp.ini,$ini(hp.ini,%r1),vit) $ini(hp.ini,%r1) }
      if (%d¬ != $null) { var %d¬ = %d¬ $+ , $+ $readini(hp.ini,$ini(hp.ini,%r1),der) $ini(hp.ini,%r1) }
      else { var %d¬ = $readini(hp.ini,$ini(hp.ini,%r1),der) $ini(hp.ini,%r1) }
      if (%e¬ != $null) { var %e¬ = %e¬ $+ , $+ $readini(hp.ini,$ini(hp.ini,%r1),emp) $ini(hp.ini,%r1) }
      else { var %e¬ = $readini(hp.ini,$ini(hp.ini,%r1),emp) $ini(hp.ini,%r1) }
      if (%n¬ != $null) { var %n¬ = %n¬ $+ , $+ $readini(hp.ini,$ini(hp.ini,%r1),nar) $ini(hp.ini,%r1) }
      else { var %n¬ = $readini(hp.ini,$ini(hp.ini,%r1),nar) $ini(hp.ini,%r1) }
      if (%¬' != $null) { var %¬' = %¬' $+ , $+ $readini(hp.ini,$ini(hp.ini,%r1),mag) $ini(hp.ini,%r1) }
      else { var %¬' = $readini(hp.ini,$ini(hp.ini,%r1),mag) $ini(hp.ini,%r1) }
    }
    inc %r1
  }
  var %a¬ = $sorttok(%a¬,44,nr)
  var %v¬ = $sorttok(%v¬,44,nr)
  var %d¬ = $sorttok(%d¬,44,nr)
  var %e¬ = $sorttok(%e¬,44,nr)
  var %n¬ = $sorttok(%n¬,44,nr)
  var %¬' = $sorttok(%¬',44,nr)
  set %alu.nom $gettok($gettok(%a¬,1,44),2,32)
  set %alu.pts $gettok($gettok(%a¬,1,44),1,32)
  set %top.vit $gettok($gettok(%v¬,1,44),2,32) 14( $+ $gettok($gettok(%v¬,1,44),1,32) $+ 14)
  set %top.der $gettok($gettok(%d¬,1,44),2,32) 14( $+ $gettok($gettok(%d¬,1,44),1,32) $+ 14)
  set %top.emp $gettok($gettok(%e¬,1,44),2,32) 14( $+ $gettok($gettok(%e¬,1,44),1,32) $+ 14)
  set %top.nar $gettok($gettok(%n¬,1,44),2,32) 14( $+ $gettok($gettok(%n¬,1,44),1,32) $+ 14)
  set %top.cas1 $gettok($gettok(%¬',1,44),2,32)
  set %top.cas2 $gettok($gettok(%¬',2,44),2,32)
  set %top.cas3 $gettok($gettok(%¬',3,44),2,32)
}
alias hist_lut {
  var %r1 = 1
  while (%r1 <= $ini(logluta.ini,0)) {
    var %cod = $ini(logluta.ini,%r1)
    var %na1 = $readini(logluta.ini,%cod,n)
    if ($readini(hp.ini,%na1,cas) == $1) { 
      if (%his.nar != $null) { set %his.nar $calc(%his.nar + 1) } 
      else { set %his.nar 1 } 
    }
    var %his.cod = $wrap(%cod, fixedsys, 9, $calc($width(a, fixedsys, 9) * 1), 1)
    if (%his.cod == D) {
      var %v1 = $readini(logluta.ini,%cod,v)
      var %d1 = $readini(logluta.ini,%cod,d)
      if ($readini(hp.ini,%v1,cas) == $1) { 
        if (%his.vit != $null) { set %his.vit $calc(%his.vit + 1) }
        else { set %his.vit 1 }
      }
      if ($readini(hp.ini,%d1,cas) == $1) { 
        if (%his.der != $null) { set %his.der $calc(%his.der + 1) }
        else { set %his.der 1 }
      }
    }
    if (%his.cod == E) {
      var %v1 = $readini(logluta.ini,%cod,v)
      var %d1 = $readini(logluta.ini,%cod,d)
      if ($readini(hp.ini,%v1,cas) == $1) { 
        if (%his.emp != $null) { set %his.emp $calc(%his.emp + 1) }
        else { set %his.emp 1 }
      }
      if ($readini(hp.ini,%d1,cas) == $1) { 
        if (%his.emp != $null) { set %his.emp $calc(%his.emp + 1) }
        else { set %his.emp 1 }
      }
    }
    inc %r1
  }
}
alias hp_bandeira {
  if ($1 == grif) { var %colo1 = 04,04 | var %colo2 = 08,08 }
  if ($1 == sons) { var %colo1 = 09,09 | var %colo2 = 15,15 }
  if ($1 == lufa) { var %colo1 = 08,08 | var %colo2 = 14,14 }
  if ($1 == corv) { var %colo1 = 11,11 | var %colo2 = 15,15 }
  inc_m %colo1 $+                $+ %colo2 $+               1,1
  inc_m %colo1 $+                $+ %colo2 $+               1,1
  inc_m %colo1 $+                $+ %colo2 $+               1,1
  inc_m %colo1 $+                $+ %colo2 $+               1,1
  inc_m %colo1 $+                $+ %colo2 $+               1,1
  inc_m %colo1 $+                $+ %colo2 $+               1,1
  inc_m %colo1 $+                $+ %colo2 $+               1,1
  inc_m %colo2 $+                $+ %colo1 $+               1,1
  inc_m %colo2 $+                $+ %colo1 $+               1,1
  inc_m %colo2 $+                $+ %colo1 $+               1,1
  inc_m %colo2 $+                $+ %colo1 $+               1,1
  inc_m %colo2 $+                $+ %colo1 $+               1,1
  inc_m %colo2 $+                $+ %colo1 $+               1,1
  inc_m %colo2 $+                $+ %colo1 $+               1,1
}
alias ta_casa {
  var %whi = 2
  while (%whi <= 5) {
    if (%whi == 2) { var %c'_ = $readini(casas.ini,$ini(casas.ini,%whi),pontos) $ini(casas.ini,%whi) }
    else { var %c'_ = %c'_ $+ , $+ $readini(casas.ini,$ini(casas.ini,%whi),pontos) $ini(casas.ini,%whi) }
    inc %whi
  }
  var %c'_ = $sorttok(%c'_,44,nr)
  if ($gettok($gettok(%c'_,1,44),2,32) == $1) { set %ta.top 1 | set %ta.pont $gettok($gettok(%c'_,1,44),1,32) }
  if ($gettok($gettok(%c'_,2,44),2,32) == $1) { set %ta.top 2 | set %ta.pont $gettok($gettok(%c'_,2,44),1,32) }
  if ($gettok($gettok(%c'_,3,44),2,32) == $1) { set %ta.top 3 | set %ta.pont $gettok($gettok(%c'_,3,44),1,32) }
  if ($gettok($gettok(%c'_,4,44),2,32) == $1) { set %ta.top 4 | set %ta.pont $gettok($gettok(%c'_,4,44),1,32) }
}
alias cx_ch {
  msg $1 1,1 15,15 0,1 $2- 15,15 1,1 
}
alias cx_hp {
  msg #Hogwarts 1,1 15,15 0,1 $1- 15,15 1,1 
}
alias inc_ch { 
  var %wht1 = $1-
  var %wht = $strip($1-)
  if ($len(%wht) > 58) { var %wht_1 = $wrap(%wht1, fixedsys, 9, $calc($width(a, fixedsys, 9) * 58), 1), %wht_2 = $wrap(%wht1, fixedsys, 9, $calc($width(a, fixedsys, 9) * 58), 2), %wht_3 = $wrap(%wht1, fixedsys, 9, $calc($width(a, fixedsys, 9) * 58), 3) }
  else { var %wht_1 = %wht1 }
  echo -a 1,1 ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯1,1 
  echo -a 1,1 %ncor2 $+ ¯ $+ %ncor $+ ,01¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯ $+ %ncor2 $+ ¯1,1 
  if (%wht_1 != $null) { echo -a 1,1 %ncor2 %ncor $+ ,01 $+(%wht_1,$str($chr(160),$ceil($calc(58 - $len($strip(%wht_1)))))) %ncor2 1,1  }
  if (%wht_2 != $null) { echo -a 1,1 %ncor2 %ncor $+ ,01 $+(%wht_2,$str($chr(160),$ceil($calc(58 - $len($strip(%wht_2)))))) %ncor2 1,1  }
  if (%wht_3 != $null) { echo -a 1,1 %ncor2 %ncor $+ ,01 $+(%wht_3,$str($chr(160),$ceil($calc(58 - $len($strip(%wht_3)))))) %ncor2 1,1  }
  echo -a 1,1 %ncor2 1,1¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯ $+ %ncor2 $+ ¯1,1 
  echo -a 1,1 %ncor $+ ,01¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯1,1 
}
alias cx_1 { 
  msg =$nick 1,1 ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯1,1 
  msg =$nick 1,1 %ncor2 $+ ¯ $+ %ncor $+ ,01¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯ $+ %ncor2 $+ ¯1,1 
}
alias cx_2 { 
  msg =$nick 1,1 %ncor2 1,1¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯ $+ %ncor2 $+ ¯1,1 
  msg =$nick 1,1 %ncor $+ ,01¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯1,1 
}
alias inc_cx { 
  var %wht1 = $1-
  var %wht = $strip($1-)
  if ($len(%wht) > 58) { var %wht_1 = $wrap(%wht1, fixedsys, 9, $calc($width(a, fixedsys, 9) * 58), 1), %wht_2 = $wrap(%wht1, fixedsys, 9, $calc($width(a, fixedsys, 9) * 58), 2), %wht_3 = $wrap(%wht1, fixedsys, 9, $calc($width(a, fixedsys, 9) * 58), 3), %wht_4 = $wrap(%wht1, fixedsys, 9, $calc($width(a, fixedsys, 9) * 58), 4), %wht_5 = $wrap(%wht1, fixedsys, 9, $calc($width(a, fixedsys, 9) * 58), 5), %wht_6 = $wrap(%wht1, fixedsys, 9, $calc($width(a, fixedsys, 9) * 58), 6), %wht_7 = $wrap(%wht1, fixedsys, 9, $calc($width(a, fixedsys, 9) * 58), 7), %wht_8 = $wrap(%wht1, fixedsys, 9, $calc($width(a, fixedsys, 9) * 58), 8), %wht_9 = $wrap(%wht1, fixedsys, 9, $calc($width(a, fixedsys, 9) * 58), 9) }
  else { var %wht_1 = %wht1 }
  if (%wht_1 != $null) { msg =$nick 1,1 %ncor2 00,01 $+(%wht_1,$str($chr(160),$ceil($calc(58 - $len($strip(%wht_1)))))) %ncor2 1,1  }
  if (%wht_2 != $null) { msg =$nick 1,1 %ncor2 00,01 $+(%wht_2,$str($chr(160),$ceil($calc(58 - $len($strip(%wht_2)))))) %ncor2 1,1  }
  if (%wht_3 != $null) { msg =$nick 1,1 %ncor2 00,01 $+(%wht_3,$str($chr(160),$ceil($calc(58 - $len($strip(%wht_3)))))) %ncor2 1,1  }
  if (%wht_4 != $null) { msg =$nick 1,1 %ncor2 00,01 $+(%wht_4,$str($chr(160),$ceil($calc(58 - $len($strip(%wht_4)))))) %ncor2 1,1  }
  if (%wht_5 != $null) { msg =$nick 1,1 %ncor2 00,01 $+(%wht_5,$str($chr(160),$ceil($calc(58 - $len($strip(%wht_5)))))) %ncor2 1,1  }
  if (%wht_6 != $null) { msg =$nick 1,1 %ncor2 00,01 $+(%wht_6,$str($chr(160),$ceil($calc(58 - $len($strip(%wht_6)))))) %ncor2 1,1  }
  if (%wht_7 != $null) { msg =$nick 1,1 %ncor2 00,01 $+(%wht_7,$str($chr(160),$ceil($calc(58 - $len($strip(%wht_7)))))) %ncor2 1,1  }
  if (%wht_8 != $null) { msg =$nick 1,1 %ncor2 00,01 $+(%wht_8,$str($chr(160),$ceil($calc(58 - $len($strip(%wht_8)))))) %ncor2 1,1  }
  if (%wht_9 != $null) { msg =$nick 1,1 %ncor2 00,01 $+(%wht_9,$str($chr(160),$ceil($calc(58 - $len($strip(%wht_9)))))) %ncor2 1,1  }
}
alias inc_m { 
  var %wht1 = $1-
  var %wht = $strip($1-)
  if ($len(%wht) > 58) { var %wht_1 = $wrap(%wht1, fixedsys, 9, $calc($width(a, fixedsys, 9) * 58), 1), %wht_2 = $wrap(%wht1, fixedsys, 9, $calc($width(a, fixedsys, 9) * 58), 2), %wht_3 = $wrap(%wht1, fixedsys, 9, $calc($width(a, fixedsys, 9) * 58), 3), %wht_4 = $wrap(%wht1, fixedsys, 9, $calc($width(a, fixedsys, 9) * 58), 4), %wht_5 = $wrap(%wht1, fixedsys, 9, $calc($width(a, fixedsys, 9) * 58), 5), %wht_6 = $wrap(%wht1, fixedsys, 9, $calc($width(a, fixedsys, 9) * 58), 6), %wht_7 = $wrap(%wht1, fixedsys, 9, $calc($width(a, fixedsys, 9) * 58), 7), %wht_8 = $wrap(%wht1, fixedsys, 9, $calc($width(a, fixedsys, 9) * 58), 8) }
  else { var %wht_1 = %wht1 }
  if (%wht_1 != $null) { msg =$nick 1,1 %ncor2 00,01 $+($str($chr(160),$ceil($calc((58 - $len($strip(%wht_1))) / 2))),%wht_1,$str($chr(160),$floor($calc((58 - $len($strip(%wht_1))) / 2)))) %ncor2 1,1  }
  if (%wht_2 != $null) { msg =$nick 1,1 %ncor2 00,01 $+($str($chr(160),$ceil($calc((58 - $len($strip(%wht_2))) / 2))),%wht_2,$str($chr(160),$floor($calc((58 - $len($strip(%wht_2))) / 2)))) %ncor2 1,1  }
  if (%wht_3 != $null) { msg =$nick 1,1 %ncor2 00,01 $+($str($chr(160),$ceil($calc((58 - $len($strip(%wht_3))) / 2))),%wht_3,$str($chr(160),$floor($calc((58 - $len($strip(%wht_3))) / 2)))) %ncor2 1,1  }
  if (%wht_4 != $null) { msg =$nick 1,1 %ncor2 00,01 $+($str($chr(160),$ceil($calc((58 - $len($strip(%wht_4))) / 2))),%wht_4,$str($chr(160),$floor($calc((58 - $len($strip(%wht_4))) / 2)))) %ncor2 1,1  }
  if (%wht_5 != $null) { msg =$nick 1,1 %ncor2 00,01 $+($str($chr(160),$ceil($calc((58 - $len($strip(%wht_5))) / 2))),%wht_5,$str($chr(160),$floor($calc((58 - $len($strip(%wht_5))) / 2)))) %ncor2 1,1  }
  if (%wht_6 != $null) { msg =$nick 1,1 %ncor2 00,01 $+($str($chr(160),$ceil($calc((58 - $len($strip(%wht_6))) / 2))),%wht_6,$str($chr(160),$floor($calc((58 - $len($strip(%wht_6))) / 2)))) %ncor2 1,1  }
  if (%wht_7 != $null) { msg =$nick 1,1 %ncor2 00,01 $+($str($chr(160),$ceil($calc((58 - $len($strip(%wht_7))) / 2))),%wht_7,$str($chr(160),$floor($calc((58 - $len($strip(%wht_7))) / 2)))) %ncor2 1,1  }
  if (%wht_8 != $null) { msg =$nick 1,1 %ncor2 00,01 $+($str($chr(160),$ceil($calc((58 - $len($strip(%wht_8))) / 2))),%wht_8,$str($chr(160),$floor($calc((58 - $len($strip(%wht_8))) / 2)))) %ncor2 1,1  }
}
alias inc_m2 {
  var %wht1 = $strip($1-)
  if ($len(%wht1) > 58) { var %wht_1 = $wrap(%wht1, fixedsys, 9, $calc($width(a, fixedsys, 9) * 58), 1), %wht_2 = $wrap(%wht1, fixedsys, 9, $calc($width(a, fixedsys, 9) * 58), 2), %wht_3 = $wrap(%wht1, fixedsys, 9, $calc($width(a, fixedsys, 9) * 58), 3), %wht_4 = $wrap(%wht1, fixedsys, 9, $calc($width(a, fixedsys, 9) * 58), 4), %wht_5 = $wrap(%wht1, fixedsys, 9, $calc($width(a, fixedsys, 9) * 58), 5), %wht_6 = $wrap(%wht1, fixedsys, 9, $calc($width(a, fixedsys, 9) * 58), 6), %wht_7 = $wrap(%wht1, fixedsys, 9, $calc($width(a, fixedsys, 9) * 58), 7), %wht_8 = $wrap(%wht1, fixedsys, 9, $calc($width(a, fixedsys, 9) * 58), 8) }
  else { var %wht_1 = %wht1 } 
  if (%wht_1 != $null) { msg =$nick 1,1 %ncor2 15,01 $+($str($chr(160),$ceil($calc((58 - $len(%wht_1)) / 2))),%wht_1,$str($chr(160),$floor($calc((58 - $len(%wht_1)) / 2)))) %ncor2 1,1  }
  if (%wht_2 != $null) { msg =$nick 1,1 %ncor2 15,01 $+($str($chr(160),$ceil($calc((58 - $len(%wht_2)) / 2))),%wht_2,$str($chr(160),$floor($calc((58 - $len(%wht_2)) / 2)))) %ncor2 1,1  }
  if (%wht_3 != $null) { msg =$nick 1,1 %ncor2 15,01 $+($str($chr(160),$ceil($calc((58 - $len(%wht_3)) / 2))),%wht_3,$str($chr(160),$floor($calc((58 - $len(%wht_3)) / 2)))) %ncor2 1,1  }
  if (%wht_4 != $null) { msg =$nick 1,1 %ncor2 15,01 $+($str($chr(160),$ceil($calc((58 - $len(%wht_4)) / 2))),%wht_4,$str($chr(160),$floor($calc((58 - $len(%wht_4)) / 2)))) %ncor2 1,1  }
  if (%wht_5 != $null) { msg =$nick 1,1 %ncor2 15,01 $+($str($chr(160),$ceil($calc((58 - $len(%wht_5)) / 2))),%wht_5,$str($chr(160),$floor($calc((58 - $len(%wht_5)) / 2)))) %ncor2 1,1  }
  if (%wht_6 != $null) { msg =$nick 1,1 %ncor2 15,01 $+($str($chr(160),$ceil($calc((58 - $len(%wht_6)) / 2))),%wht_6,$str($chr(160),$floor($calc((58 - $len(%wht_6)) / 2)))) %ncor2 1,1  }
  if (%wht_7 != $null) { msg =$nick 1,1 %ncor2 15,01 $+($str($chr(160),$ceil($calc((58 - $len(%wht_7)) / 2))),%wht_7,$str($chr(160),$floor($calc((58 - $len(%wht_7)) / 2)))) %ncor2 1,1  }
  if (%wht_8 != $null) { msg =$nick 1,1 %ncor2 15,01 $+($str($chr(160),$ceil($calc((58 - $len(%wht_8)) / 2))),%wht_8,$str($chr(160),$floor($calc((58 - $len(%wht_8)) / 2)))) %ncor2 1,1  }
}
alias cod_luta {
  var %cod = $1
  if ($readini(logluta.ini,%cod,v) == $null) { cx_1 | inc_m 4Código não encontrado | cx_2 | halt }
  var %cod2 = $wrap(%cod, fixedsys, 9, $calc($width(a, fixedsys, 9) * 1), 1)
  if (%cod2 == D) {
    cx_1
    inc_m Informação de Duelo
    inc_cx 1-
    inc_cx Código15: %ncor $+ $upper(%cod)
    inc_cx Duelo15: %ncor $+ $readini(logluta.ini,%cod,v) 15vs %ncor $+ $readini(logluta.ini,%cod,d)
    inc_cx Narrado por15: %ncor $+ $readini(logluta.ini,%cod,n)
    if ($readini(logluta.ini,%cod,op) != $null) { inc_cx Atualizador15: %ncor $+ $readini(logluta.ini,%cod,op) }
    inc_cx 1-
    inc_cx %ncor $+ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    inc_cx 15 $+ $readini(logluta.ini,%cod,v) 0saiu vitorioso e perdeu15 $readini(logluta.ini,%cod,vv) $+ 15% 0de vigor
    inc_cx 15 $+ $readini(logluta.ini,%cod,d) 0foi derrotado e perdeu15 $readini(logluta.ini,%cod,dv) $+ 15% 0de vigor
    cx_2
  }
  if (%cod2 == E) {
    cx_1
    inc_m Informação de Duelo
    inc_cx 1-
    inc_cx Código15: %ncor $+ $upper(%cod)
    inc_cx Duelo15: %ncor $+ $readini(logluta.ini,%cod,v) 15vs %ncor $+ $readini(logluta.ini,%cod,d)
    inc_cx Narrado por15: %ncor $+ $readini(logluta.ini,%cod,n)
    if ($readini(logluta.ini,%cod,op) != $null) { inc_cx Atualizador15: %ncor $+ $readini(logluta.ini,%cod,op) }
    inc_cx 1-
    inc_cx %ncor $+ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
    inc_m Houve um Empate!
    inc_cx 15 $+ $readini(logluta.ini,%cod,v) 0perdeu15 $readini(logluta.ini,%cod,vv) $+ 15% 0de vigor
    inc_cx 15 $+ $readini(logluta.ini,%cod,d) 0perdeu15 $readini(logluta.ini,%cod,dv) $+ 15% 0de vigor
    cx_2
  }

}
alias ver_luta {
  var %pir = 1
  var %q11 = 0
  while (%pir <= $ini(logluta.ini,0)) {
    var %cod = $ini(logluta.ini,%pir)
    if ($readini(logluta.ini,%cod,v) == %nick1) && ($readini(logluta.ini,%cod,d) == %nick2) { var %dd1 = %dd1 %cod | inc %q11 }
    if ($readini(logluta.ini,%cod,v) == %nick2) && ($readini(logluta.ini,%cod,d) == %nick1) { var %dd1 = %dd1 %cod | inc %q11 }
    inc %pir
  }
  if (%dd1 != $null) { var %go11 = %dd1 }
  if (%q11 != 0) {
    cx_1
    inc_m Hogwarts - Registro de Duelos
    inc_cx 1-
    inc_cx Duelos15: %ncor $+ %nick1 15vs %ncor $+ %nick2 
    inc_cx Quantidade: %ncor $+ %q11 
    inc_m %ncor $+ Códigos
    inc_cx %go11
    inc_cx 1-
    inc_cx Para informações sobre o duelo digite %ncor $+ !15View <código>
    cx_2
  }
  else {
    cx_1
    inc_cx Nenhum duelo registrado entre os nicks informados.
    cx_2
  }
}
alias can_luta {
  var %pir = 1
  var %q11 = 0
  while (%pir <= $ini(canlog.ini,0)) {
    var %cod = $ini(canlog.ini,%pir)
    if ($readini(canlog.ini,%cod,v) == %nick1) && ($readini(canlog.ini,%cod,d) == %nick2) { var %dd1 = %dd1 %cod | inc %q11 }
    if ($readini(canlog.ini,%cod,v) == %nick2) && ($readini(canlog.ini,%cod,d) == %nick1) { var %dd1 = %dd1 %cod | inc %q11 }
    inc %pir
  }
  if (%dd1 != $null) { var %go11 = %dd1 }
  if (%q11 != 0) {
    cx_1
    inc_m Hogwarts - Registro de Duelos
    inc_cx 1-
    inc_cx Duelos15: %ncor $+ %nick1 15vs %ncor $+ %nick2 
    inc_cx Quantidade: %ncor $+ %q11 
    inc_m %ncor $+ Códigos
    inc_cx %go11
    cx_2
  }
  else {
    cx_1
    inc_cx Nenhum duelo registrado entre os nicks informados.
    cx_2
  }
}

on *:connect: {
  if ($network == Virtualife) {
    nick Hogwarts
    ns identify hogwarts4242
    join #Hogwarts
    join #Duelos
    join #HPArena2
    join #HPArena3
    join #HPEventos
    join #HPQuadribol
    /timernovaaula  1 %antesaula //aula.inicio
    /timeravisoaula 1 $calc(%antesaula - 60) //aviso.aula
    /timerlibera  1 14400 //soltar_pris
  }
}
alias hp_expan { 
  var %random = $rand(1,10)
  if (%random == 1) { var %sit = sim }
  if (%random == 2) { var %sit = sim }
  if (%random == 3) { var %sit = nao }
  if (%random == 4) { var %sit = nao }
  if (%random == 5) { var %sit = sim }
  if (%random == 6) { var %sit = nao }
  if (%random == 7) { var %sit = nao }
  if (%random == 8) { var %sit = nao }
  if (%random == 9) { var %sit = sim }
  if (%random == 10) { var %sit = nao }
  if (%sit == nao) { 
    var %viglose = $rand(1,3) 
    var %holose = $calc($rand(0,6) * 5)
    if (%holose != 0) { cx_ch # 7 $+ $nick 0tenta concentrar-se mas não é suficiente e perde07 %holose $+ 7% 0de HP. }
    if (%holose == 0) { cx_ch # 7 $+ $nick 0tenta concentrar-se mas não é suficiente porém não perde HP. }  
    notice $nick 1,1 15,15 0,1 Você perdeu07 %viglose $+ 7% 0de vigor devido a tentativa de concentração em duelo. 15,15 1,1 
    writeini hp.ini $nick vig $calc($readini(hp.ini,$nick,vig) - %viglose)
    halt
  }
  if (%sit == sim) { 
    var %viglose1 = $rand(2,5)
    var %elev = $calc($rand(5,15) * 10) 
    var %nick = $readini(hp.ini,$nick,nick)
    var %mag = $readini(hp.ini,%nick,mag)
    var %niv = 300
    var %ini = 300
    var %mag2 = $calc(((%mag * %elev) / 100) + %mag)
    while (%mag2 >= %ini) {
      if (%nv2 == $null) { set %nv2 1 }
      set %nv2 $calc(%nv2 + 1)
      var %niv = $calc(%niv + 100)
      var %ini = $calc(%ini + %niv)
    }
    if (%nv == $null) { set %nv 1 }
    cx_ch # 07 $+ $nick 0concentrou-se aumentando em07 %elev $+ 7% 0 sua Magia, ficando15:07 $int(%mag2) 0(Nível15:07 %nv2 $+ 0).
    notice $nick 1,1 15,15 0,1 Você perdeu07 %viglose1 $+ 7% 0de vigor devido a concentração em duelo. 15,15 1,1 
    writeini hp.ini $nick vig $calc($readini(hp.ini,$nick,vig) - %viglose1)
  }
}
alias logo { return 5[07+05HP7+05] }
alias mc { msg =$nick $logo $1- }
alias mch { msg $chan $logo $1- }
alias mcd { msg = $+ [ %ndd ] $logo $1- }
alias checa_logado { if ($readini(hp.ini,$nick,id) != on) { notice $nick 1,1 15,15 0,1 Você não está logado. | halt } }
alias check_ala_hp {
  if ($readini(hp.ini,$nick,vig) > 0) { cx_1 | inc_cx Você não precisa vir aqui ainda. Volte quando seu Vigor Físico for 0 | cx_2 | halt }
  if ($readini(hp.ini,$nick,vig) <= 0) && ($readini(hp.ini,$nick,ala_dia) == $null) { 
    cx_1 
    inc_cx 15[Enfermeira] 0Hmmm, você extrapolou não foi? descanse agora... Volte amanhã e venha falar comigo denovo!
    cx_2
    writeini hp.ini $nick ala_hos sim
    writeini hp.ini $nick ala_dia $date
    halt
  }
  if ($readini(hp.ini,$nick,ala_hos) == sim) && ($readini(hp.ini,$nick,ala_dia) == $date) {
    cx_1 
    inc_cx 15[Enfermeira] 0Você extrapolou bastante! Agora tem que esperar até amanhã para poder voltar às suas atividades. Seja Paciente!
    cx_2
    halt
  }
  if ($readini(hp.ini,$nick,ala_hos) == sim) && ($readini(hp.ini,$nick,ala_dia) != $date) { 
    cx_1 
    inc_cx 15[Enfermeira] 0Ok! Vejo que você está melhor agora... Agora vá para %ncor $+ !15Hogsmeade 0e se cuide para que você não precise voltar aqui novamente.
    cx_2
    writeini hp.ini $nick ala_dia $null
    writeini hp.ini $nick ala_hos não
    writeini hp.ini $nick vig 10
    halt
  }
}
alias check_ala_envio {
  if ($readini(hp.ini,$1,vig) <= 0) && ($readini(hp.ini,$1,ala_hos) == sim) { cx_ch # Você não pode lutar, você está na Ala Hospitalar! | halt }
  if ($readini(hp.ini,$1,vig) <= 0) && ($readini(hp.ini,$1,ala_hos) != sim) { cx_ch # Você não pode lutar, você está sem vigor. Vá para a 7!15Ala Hospitalar. | halt }
  if ($readini(hp.ini,$2,vig) <= 0) && ($readini(hp.ini,$2,ala_hos) == sim) { cx_ch # $2 não pode lutar, está na Ala Hospitalar! | halt }
  if ($readini(hp.ini,$2,vig) <= 0) && ($readini(hp.ini,$2,ala_hos) != sim) { cx_ch # $2 não pode lutar, está sem vigor. Vá para a 7!15Ala Hospitalar. | halt }
}
alias check_ala_luta {
  if ($readini(hp.ini,%luta1,vig) <= 0) && ($readini(hp.ini,%luta1,ala_hos) == sim) { cx_ch # O Duelo não pode ser completado,07 %luta1 0Está na Ala Hospitalar. | halt }
  if ($readini(hp.ini,%luta1,vig) <= 0) && ($readini(hp.ini,%luta1,ala_hos) == não) { cx_ch # O Duelo não pode ser completado,07 %luta1 0Está sem Vigor Físico, Corra para a 7!15Ala Hospitalar. | halt }
  if ($readini(hp.ini,%luta1,vig) <= 0) && ($readini(hp.ini,%luta1,ala_hos) == $null) { cx_ch # O Duelo não pode ser completado,07 %luta1 0Está sem Vigor Físico, Corra para a 7!15Ala Hospitalar. | halt }
  if ($readini(hp.ini,%luta2,vig) <= 0) && ($readini(hp.ini,%luta2,ala_hos) == sim) { cx_ch # O Duelo não pode ser completado,07 %luta2 0Está na Ala Hospitalar. | halt }
  if ($readini(hp.ini,%luta2,vig) <= 0) && ($readini(hp.ini,%luta2,ala_hos) == não) { cx_ch # O Duelo não pode ser completado,07 %luta2 0Está sem Vigor Físico, Corra para a 7!15Ala Hospitalar. | halt }
  if ($readini(hp.ini,%luta2,vig) <= 0) && ($readini(hp.ini,%luta2,ala_hos) == $null) { cx_ch # O Duelo não pode ser completado,07 %luta2 0Está sem Vigor Físico, Corra para a 7!15Ala Hospitalar. | halt }
  if ($readini(hp.ini,%luta3,vig) <= 0) && ($readini(hp.ini,%luta3,ala_hos) == sim) { cx_ch # O Duelo não pode ser completado,07 %luta3 0Está na Ala Hospitalar. | halt }
  if ($readini(hp.ini,%luta3,vig) <= 0) && ($readini(hp.ini,%luta3,ala_hos) == não) { cx_ch # O Duelo não pode ser completado,07 %luta3 0Está sem Vigor Físico, Corra para a 7!15Ala Hospitalar. | halt }
  if ($readini(hp.ini,%luta3,vig) <= 0) && ($readini(hp.ini,%luta3,ala_hos) == $null) { cx_ch # O Duelo não pode ser completado,07 %luta3 0Está sem Vigor Físico, Corra para a 7!15Ala Hospitalar. | halt }
  unset %luta1
  unset %luta2
  unset %luta3  
}
alias check_treino_vig {
  if ($readini(hp.ini,$nick,vig) <= 0) && ($readini(hp.ini,$nick,ala_hos) == sim) { cx_1 | inc_cx 4Você não pode treinar, Você está na Ala Hospitalar. | cx_2 | halt }
  if ($readini(hp.ini,$nick,vig) <= 0) && ($readini(hp.ini,$nick,ala_hos) == não) { cx_1 | inc_cx 4Você não pode treinar, você está sem Vigor Físico, Corra para a 7!15Ala Hospitalar.  | cx_2 | halt }
  if ($readini(hp.ini,$nick,vig) <= 0) && ($readini(hp.ini,$nick,ala_hos) == $null) { cx_1 | inc_cx 4Você não pode treinar, você está sem Vigor Físico, Corra para a 7!15Ala Hospitalar. | cx_2 | halt }
}
alias chat_hp {
  var %x = $chat(0)
  var %x1 = 1
  var %cas = $readini(hp.ini,$nick,cas)
  if (%cas == corvinal) { set %l1 7[1+2CORV1+7] | set %cr 12 }
  if (%cas == grifinória) { set %l1 4[1+4GRIF1+4] | set %cr 04 }
  if (%cas == lufa-lufa) { set %l1 1[1+7LUFA1+1] | set %cr 07 }
  if (%cas == sonserina) { set %l1 15[1+3SONS1+15] | set %cr 03 }
  while (%x1 <= %x) {
    var %us = $chat(%x1)
    var %cas1 = $readini(hp.ini,%us,cas)
    if ($readini(accesshp.ini,$nick,nv) >= 1) { var %mm = $replace($readini(accesshp.ini,$nick,nv),10,!,1,+,2,%,3,@,4,@,5,!) }
    if (%chat.free != on) {
      if (%cas == %cas1) && (%us != $nick) { 
        if (*ACTION* iswm $gettok(%fala,1,32)) { msg [ = $+ [ %us ] ] %l1 6* %mm $+ $nick $+ 01 $+ $replace(%fala,ACTION,6) }
        else { msg [ = $+ [ %us ] ] %l1 1< $+ %cr $+ %mm $+ $nick $+ 1> 01 $+ %fala }
      }
    }
    else { if (%us != $nick) { 
        if (*ACTION* iswm $gettok(%fala,1,32)) { msg [ = $+ [ %us ] ] %l1 6* %mm $+ $nick $+ 01 $+ $replace(%fala,ACTION,6) }
        else { msg [ = $+ [ %us ] ] %l1 1< $+ %cr $+ %mm $+ $nick $+ 1> 01 $+ %fala }
      }
    }
    inc %x1
  }
  unset %l1
  unset %cr
  unset %fala
}
alias verify_nivel {
  set %nv 1
  var %mag = $readini(hp.ini,%nick,mag)
  var %niv = 300
  var %ini = 300
  while (%mag >= %ini) {
    set %nv $calc(%nv + 1)
    var %niv = $calc(%niv + 100)
    var %ini = $calc(%ini + %niv)
  }
}
alias nivel_nick {
  var %mag = $readini(hp.ini,$1,mag)
  var %niv = 300
  var %ini = %niv
  var %ni = 1
  while (%mag >= %ini) {
    inc %ni
    var %niv = $calc(%niv + 100)
    var %ini = $calc(%ini + %niv)
  }
  return %ni
}
alias check_nivel { 
  set %nv 1
  var %niv = 300
  var %ini = 300
  var %mag = $1
  while (%mag >= %ini) {
    set %nv $calc(%nv + 1)
    var %niv = $calc(%niv + 100)
    var %ini = $calc(%ini + %niv)
  }
  set %falta $calc(%ini - %mag)
  if (%nv == $null) { set %nv 1 }
  return %nv
}
alias verify_nivel2 {
  set %nv 1
  var %nick = $readini(hp.ini,%nick1,nick)
  var %mag = $readini(hp.ini,%nick1,mag)
  var %niv = 300
  var %ini = %niv
  while (%mag >= %ini) {
    set %nv $calc(%nv + 1)
    var %niv = $calc(%niv + 100)
    var %ini = $calc(%ini + %niv)
  }
  set %falta $calc(%ini - %mag)
}
alias all_hp {
  var %x = $chat(0)
  var %x1 = 1
  var %cas = $readini(hp.ini,$nick,cas)
  if (%cas == corvinal) { set %l1 7[1+2CORV1+7] | set %cr 11 }
  if (%cas == grifinória) { set %l1 4[1+4GRIF1+4] | set %cr 04 }
  if (%cas == lufa-lufa) { set %l1 1[1+7LUFA1+1] | set %cr 07 }
  if (%cas == sonserina) { set %l1 15[1+3SONS1+15] | set %cr 09 }
  while (%x1 <= %x) {
    var %us = $chat(%x1)
    var %cas1 = $readini(hp.ini,%us,cas)
    if (%us != $nick) { msg [ = $+ [ %us ] ] %l1 1< $+ %cr $+ $nick $+ 1> %cr $+ @Global 01 $+ %fala }
    inc %x1
  }
  unset %l1
  unset %cr
  unset %fala
}
alias pm_hp {
  var %cas = $readini(hp.ini,$nick,cas)
  if (%cas == corvinal) { set %l1 7[1+2CORV1+7] | set %cr 11 }
  if (%cas == grifinória) { set %l1 4[1+4GRIF1+4] | set %cr 04 }
  if (%cas == lufa-lufa) { set %l1 1[1+7LUFA1+1] | set %cr 07 }
  if (%cas == sonserina) { set %l1 15[1+3SONS1+15] | set %cr 09 }
  msg [ = $+ [ %nick.pm ] ] %l1 1< $+ %cr $+ $nick $+ 1> %cr $+ PM 01 $+ %fala
  unset %l1
  unset %cr
  unset %fala
}
alias online_hp {
  if ($chat(0) > 0) {
    cx_1
    var %a = 1
    inc_m Listando os usuários conectados no bot...
    inc_m %ncor $+ ¯¯¯¯¯¯¯¯ ¯¯ ¯¯¯¯¯¯¯¯ ¯¯¯¯¯¯¯¯¯¯ ¯¯ ¯¯¯¯¯¯
    while (%a <= $chat(0)) {
      if ($readini(hp.ini,$nick,id) == on) {
        var %us = $chat(%a)
        var %cas = $readini(hp.ini,%us,cas)
        if (%cas == corvinal) { set %cr 11 }
        if (%cas == grifinória) { set %cr 04 }
        if (%cas == lufa-lufa) { set %cr 08 }
        if (%cas == sonserina) { set %cr 03 }
        inc_cx 1-
        inc_cx $readini(hp.ini,%us,sex) 14| %cr $+ %us 0- %cr $+ %cas
        if ($readini(accesshp.ini,%us,nv) != $null) { inc_cx 4 $+ $replace($readini(accesshp.ini,%us,nv),10,!,1,+,2,+,3,@,4,@,5,!,$null,2) 14| 0Nível15/ $+ %cr $+ $check_nivel($readini(hp.ini,%us,mag)) $+ $str($chr(160),$calc(10 - $len($check_nivel($readini(hp.ini,%us,mag))))) 0Magia15/ $+ %cr $+ $replace($bytes($readini(hp.ini,%us,mag),db),$chr(44),$chr(46)) }
        else { inc_cx   14| 0Nível15/ $+ %cr $+ $check_nivel($readini(hp.ini,%us,mag)) $+ $str($chr(160),$calc(10 - $len($check_nivel($readini(hp.ini,%us,mag))))) 0Magia15/ $+ %cr $+ $replace($bytes($readini(hp.ini,%us,mag),db),$chr(44),$chr(46)) }
        inc %a
      }
    }
    cx_2
  }
}
alias banco_hp {
  cx_1
  inc_m Banco Gringotes
  inc_cx 1-
  inc_cx Veja os comandos relacionados ao banco
  inc_cx 1-
  inc_cx      %ncor $+ !15Abrir Conta
  inc_cx      %ncor $+ !15Acessar Conta
  inc_cx      %ncor $+ !15Conta
  inc_cx      %ncor $+ !15Depositar < $+ %ncor $+ valor15>
  inc_cx      %ncor $+ !15Retirar < $+ %ncor $+ valor15>
  inc_cx      %ncor $+ !15Transferir  < $+ %ncor $+ nick15> < $+ %ncor $+ valor15>
  inc_cx 1-
  inc_cx Se precisar de ajuda, basta falar com um de nossos 12@15 gerentes.
  cx_2
}
alias treino_hp {
  set %nick $nick
  verify_nivel
  var %pn = $calc(%nv * 2)
  var %ganho = $calc($rand(50,70) + %pn)
  var %tm = $rand(5,10)
  var %temp = $calc(%tm * 60)
  var %mag = $readini(hp.ini,%nick,mag)
  writeini hp.ini %nick treinando sim
  timertr $+ $nick $+ 1 1 %temp writeini hp.ini %nick mag $calc(%mag + %ganho)
  timertr $+ $nick $+ 2 1 %temp notice $nick 1,1 15,15 0,1 Você completou com êxito seu treino básico de magia. 15,15 1,1 
  timertr $+ $nick $+ 3 1 %temp writeini hp.ini %nick treinando nao
  timertr $+ $nick $+ 4 1 %temp writeini hp.ini %nick treino $date
  cx_1
  inc_m Hogwarts - Treino
  var %raqq = $rand(1,4)
  inc_cx 1-
  if (%raqq == 1) { inc_cx Você começa a movimentar a varinha e Exclama %ncor $+ Vingardium %ncor $+ Leviosa 0e faz uma pena começar a levitar em sua frente mas cai logo em seguida. }
  if (%raqq == 2) { inc_cx Concentrando-se na melhor lembrança que já teve você exclama %ncor $+ Expecto %ncor $+ Patronum 0e uma mancha acinzentada surge na ponta da sua varinha, porém ainda desforme. }
  if (%raqq == 3) { inc_cx Apontando sua varinha para uma pedra a frente você exclama %ncor $+ Engorgio 0e a pedra aumenta de tamanho ficando meio desregular. }
  if (%raqq == 4) { inc_cx Enchendo seu coração de rancor e ódio, determinadamente aponta sua varinha para uma aranha próxima e exclama %ncor $+ Avada %ncor $+ Kedavra 0e a aranha fica dura no chão. }
  inc_cx 1-
  inc_cx Dedicadamente permanece treinando o feitiço até que não haja nenhuma falha.
  inc_cx 1-
  inc_cx Duração15: %ncor $+ %tm Minutos
  inc_cx Ganho15: %ncor $+ %ganho
  inc_cx Magia Final15: %ncor $+ $calc($readini(hp.ini,$nick,mag) + %ganho)
  inc_cx 1-
  inc_m 4Não duele enquanto estiver treinando
  cx_2
}
alias abrir_conta {
  var %cas = $readini(hp.ini,$nick,cas)
  if (%cas == corvinal) { var %cr = 02 | var %cass = Corvinal }
  if (%cas == grifinória) { var %cr = 04 | var %cass = Grifinória }
  if (%cas == lufa-lufa) { var %cr = 07 | var %cass = Lufa-Lufa }
  if (%cas == sonserina) { var %cr = 03 | var %cass = Sonserina }
  if ($readini(banc.ini,$nick,acc) != $null) { cx_1 | inc_cx Você já possui uma conta no nosso banco. | cx_2 | halt }
  var %gal = $readini(hp.ini,$nick,gal)
  if (%gal < 50) { cx_1 | inc_cx Você precisa fazer um depósito mínimo de 0750 0nuques para abrir sua conta. | cx_2 | halt }
  :refazendo_conta_gring
  writeini banc.ini $nick acc $+($rand(0,9),$rand(0,9),$rand(0,9),-,$rand(A,Z),$rand(A,Z))
  var %acc = $readini(banc.ini,$nick,acc)
  if (*%acc* iswm %banc.accs) { goto refazendo_conta_gring }
  set %banc.accs %banc.accs %acc
  writeini banc.ini $nick sen $+($rand(A,Z),$rand(A,Z),$rand(A,Z),$rand(A,Z),$rand(A,Z))
  writeini banc.ini $nick nick $nick
  writeini banc.ini $nick gal 50
  writeini banc.ini $nick lasd 50
  writeini hp.ini $nick gal $calc(%gal - 50)
  var %corn = [ $nick ] $+ .ini
  writeini %corn B013 msg Olá $nick $+ , Sua Conta no banco foi confirmada! Seu identificador é: $readini(banc.ini,$nick,acc) e sua senha é: $readini(banc.ini,$nick,sen) $+ . Por favor, não delete essa mensagem.
  writeini %corn B013 from Banco Gringotes
  writeini %corn B013 data $date
  writeini %corn B013 read nao
  notice $nick 1,1 15,15 0,1 Você acaba de receber uma mensagem em seu Corujal! 15,15 1,1 
  cx_1
  inc_cx %ncor $+ $nick $+ 0, sua conta foi criada.
  inc_cx Lembre-se dos seguintes dados que eu vou te passar, sem eles você não poderá acessar a sua conta.
  inc_cx O Identificador de sua conta é %ncor $+ $readini(banc.ini,$nick,acc) 0e a senha é %ncor $+ $readini(banc.ini,$nick,sen)
  inc_cx Para sua segurança, não dê o número do %ncor $+ identificador 0da sua conta nem %ncor $+ senha 0para ninguém!
  inc_cx Agora você já pode acessá-la digitando o comando %ncor $+ !15Acessar 15Conta
  cx_2
}
alias acessar_conta {
  if ($readini(banc.ini,$nick,acc) == $null) { cx_1 | inc_cx Você precisa criar sua conta no banco primeiro. | cx_2 | halt }
  if ($readini(hp.ini,$nick,lob2) == on) { cx_1 | Você já está acessando sua conta. | cx_2 | halt }
  cx_1
  inc_cx Olá $nick $+ !
  inc_cx Digite seu %ncor $+ Identificador 0e %ncor $+ Senha 0Por favor.
  cx_2
  writeini hp.ini $nick lob sim
}
alias dados_hp {
  set %nick %nd
  var %cas = $readini(hp.ini,%nick,cas)
  if (%cas == corvinal) { set %ncor2 11,11 | set %ncor 11 }
  if (%cas == grifinória) { set %ncor2 04,04 | set %ncor 04 }
  if (%cas == lufa-lufa) { set %ncor2 08,08 | set %ncor 08 }
  if (%cas == sonserina) { set %ncor2 09,09 | set %ncor 09 }
  if (%cas == $null) { set %ncor2 15,15 | set %ncor 15 }
  var %nom = $readini(hp.ini,%nd,nick)
  var %ld = $readini(hp.ini,%nd,ld)
  var %lh = $readini(hp.ini,%nd,lh)
  var %age = $readini(hp.ini,%nd,age)
  var %cas = $readini(hp.ini,%nd,cas)
  var %bru = $readini(hp.ini,%nd,bru)
  var %sex = $readini(hp.ini,%nd,sex)
  var %mag = $replace($bytes($readini(hp.ini,%nd,mag),db),$chr(44),$chr(46))
  var %gal = $readini(hp.ini,%nd,gal)
  var %din = $din_x(%gal)
  var %car = $readini(hp.ini,%nd,car)
  var %ano = $readini(hp.ini,%nd,ano)
  var %vig = $readini(hp.ini,%nd,vig)
  var %ves = $readini(hp.ini,%nd,ves)
  var %vit = $readini(hp.ini,%nd,vit)
  var %der = $readini(hp.ini,%nd,der)
  var %emp = $readini(hp.ini,%nd,emp)
  var %nar = $readini(hp.ini,%nd,nar)
  var %pts = $readini(hp.ini,%nd,pts)
  if (%pts == $null) { var %pts = 0 }
  var %ama = $readini(hp.ini,%nd,ama)
  if (%ama == $null) { var %ama = Nenhuma }
  var %ani = $readini(hp.ini,%nd,ani)
  if (%ani == $null) { var %ani = Nenhum }
  var %var = $readini(hp.ini,%nd,var)
  if (%var == $null) { var %var = Nenhuma }
  var %ite = $readini(hp.ini,%nd,ite)
  if (%ite == $null) { var %ite = Nenhum }
  if (%cas == corvinal) { set %cr 02 }
  if (%cas == grifinória) { set %cr 04 }
  if (%cas == lufa-lufa) { set %cr 07 }
  if (%cas == sonserina) { set %cr 03 }
  var %cor1 = 04,04
  var %cor2 = 15,15
  var %vigor = $floor($calc(%vig / 5))
  var %vigor2 = $+(%cor1,$str($chr(160),%vigor),%cor2,$str($chr(160),$floor($calc(20 - %vigor))))
  if (%vig == 100) { var %vigor2 = $+(%cor1,$str($chr(160),%vigor)) }
  cx_1
  inc_m 00Hogwarts 14-00 Dados
  inc_m %ncor $+ %nom 15( $+ %ncor $+ %sex $+ 15) %ncor $+ %age anos 
  inc_m 14Último login em %ld às %lh
  inc_cx 1-
  inc_cx 15Casa14: %ncor $+ %cas 15( $+ %ncor $+ %ano $+ º Ano15)
  inc_cx 15Cargo14: %ncor $+ %car
  inc_cx 15Dinheiro14: %din 14/15 Magia14: %ncor $+ %mag 14/15 Nível14: %ncor $+ $nivel_nick(%nick)
  inc_m 1-
  inc_m 00Estatísticas 14-00 Duelos
  inc_cx 15Narrações14: %ncor $+ %nar 14/ 15Duelos14: %ncor $+ $calc(%vit + %emp + %der)
  inc_cx 9VIT14: %ncor $+ %vit $+ $str($chr(160),$calc(4 - $len(%vit))) 09,09 $+ $str($chr(160),$ceil($calc(((%vit * 100) / (%vit + %emp + %der)) / 10))) $+ 01,01 $+ $str($chr(160),$calc(10 - ($ceil($calc((%vit * 100) / (%vit + %emp + %der))) / 10))) 14 $+ $int($calc((%vit * 100) / $calc(%vit + %emp + %der))) $+ 14% 15Vigor14: %vigor2 $+ 15,01 %vig $+ 15%
  inc_cx 8EMP14: %ncor $+ %emp $+ $str($chr(160),$calc(4 - $len(%emp))) 08,08 $+ $str($chr(160),$ceil($calc(((%emp * 100) / (%vit + %emp + %der)) / 10))) $+ 01,01 $+ $str($chr(160),$calc(10 - ($ceil($calc((%emp * 100) / (%vit + %emp + %der))) / 10))) 14 $+ $int($calc((%emp * 100) / $calc(%vit + %emp + %der))) $+ 14%
  inc_cx 4DER14: %ncor $+ %der $+ $str($chr(160),$calc(4 - $len(%der))) 04,04 $+ $str($chr(160),$ceil($calc(((%der * 100) / (%vit + %emp + %der)) / 10))) $+ 01,01 $+ $str($chr(160),$calc(10 - ($ceil($calc((%der * 100) / (%vit + %emp + %der))) / 10))) 14 $+ $int($calc((%der * 100) / $calc(%vit + %emp + %der))) $+ 14%
  inc_m 1-
  inc_m 00Varinha Mágica
  inc_cx %ncor $+ %var 
  inc_m 1-
  inc_m 00+
  inc_cx 15Aptidão Mágica14: %ncor $+ %ama
  inc_cx 15Vestimenta14: %ncor $+ %ves
  inc_cx 15Animal14: %ncor $+ %ani
  inc_cx 15Pontos14: %ncor $+ %pts
  inc_m 1-
  inc_m 00Outros Itens
  inc_cx %ncor2 $+ 1 QTD 1,1 %ncor2 $+ 1 Item                               1,1 %ncor2 $+ 1 Tipo          1,1
  var %wd = 1
  var %wd1 = $numtok(%ite,44)
  var %jafoi = Nada
  while (%wd <= %wd1) { 
    var %pa = $gettok(%ite,%wd,44)
    if ($matchtok(%jafoi,%pa,0,44) == 0) {
      var %num_it = $matchtok(%ite,%pa,0,44)
      var %pa2 = $replace(%pa,$chr(32),$chr(46))
      var %tip_it = $readini(loja.ini,%pa2,tipo)
      if (%tip_it == $null) { var %tip_it = - }
      inc_cx 15 $+ %num_it $+ $str($chr(160),$calc(6 - $len(%num_ite))) $+ %pa $+ $str($chr(160),$calc(37 - $len(%pa2))) $+ %tip_it 
      var %jafoi = %jafoi $+, $+ %pa
    }
    inc %wd
  }
  cx_2
}
alias chapeu_seletor {
  var %bru = $readini(hp.ini,$nick,bru)
  cx_1
  inc_cx 00[Chapéu Seletor]
  inc_cx 00Hmmm... $+ %ncor $nick 00você tem um futuro brilhante como $+ %ncor %bru $+ 0...
  inc_cx 00Vejamos... Será que tem ambição? Ou é de grande coragem? Talvez estudioso... 
  inc_cx 7Já me decidi.
  var %x = 1
  var %x2 = $ini(hp.ini,0)
  var %xs = 0
  var %xc = 0
  var %xl = 0
  var %xg = 0
  while (%x <= %x2) {
    var %x3 = $ini(hp.ini,%x)
    if ($readini(hp.ini,%x3,cas) == Sonserina) { var %xs = $calc(%xs + 1) }
    if ($readini(hp.ini,%x3,cas) == Corvinal) { var %xc = $calc(%xc + 1) }
    if ($readini(hp.ini,%x3,cas) == Lufa-Lufa) { var %xl = $calc(%xl + 1) }
    if ($readini(hp.ini,%x3,cas) == Grifinória) { var %xg = $calc(%xg + 1) }
    inc %x
  }
  var %sort¬ = %xs 1 $+ . $+ %xc 2 $+ . %+ %xl 3 $+ . $+ %xg 4
  var %sort¬ = $sorttok(%sort¬,46,n)
  var %casa = $gettok($gettok(%sort¬,1,46),2,32)
  if (%casa == 1) { var %casa = Sonserina | var %corcasa = 03 }
  if (%casa == 2) { var %casa = Corvinal | var %corcasa = 11 }
  if (%casa == 3) { var %casa = Lufa-Lufa | var %corcasa = 08 }
  if (%casa == 4) { var %casa = Grifinória | var %corcasa = 04 }
  inc_cx 00A voz do Chapéu Seletor ecoa no Salão Principal e todos escutam: %corcasa $+ %casa $+ 5.
  msg #Hogwarts 1,1 15,15 00,1 O Chapéu Seletor informa a todos os presentes que $nick 00ficará em %corcasa $+ %casa $+ 0! 15,15 1,1 
  inc_cx 00Parabéns jovem %bru $+ ... Agora digite sua 7chave (senha) 00para entrar na escola.
  cx_2
  var %nana = $readini(casas.ini,%casa,alunos)
  writeini casas.ini %casa alunos %nana $+ , $+ $nick
  writeini hp.ini $nick nick $nick
  writeini hp.ini $nick cas %casa
  writeini hp.ini $nick mag 1
  writeini hp.ini $nick vig 100
  writeini hp.ini $nick gal 100
  writeini hp.ini $nick car Estudante
  writeini hp.ini $nick ano 1
  writeini hp.ini $nick dc $date
  writeini hp.ini $nick ves Roupa dos Trouxas
  writeini hp.ini $nick ite Roupa dos Trouxas
  writeini hp.ini $nick vit 0
  writeini hp.ini $nick emp 0
  writeini hp.ini $nick der 0
  writeini hp.ini $nick nar 0
  writeini hp.ini $nick id off
}
alias check_pico_HP {
  if ($readini(picohp.ini,pico,num) == $null) {
    writeini picohp.ini pico num $nick(#Hogwarts,0)
    cx_hp Pico do canal Superado! Novo pico15:7  $+ $readini(picohp.ini,pico,num) $+  0usuários.
  }
  if ($nick(#Hogwarts,0) > $readini(picohp.ini,pico,num)) {
    writeini picohp.ini pico num $nick(#Hogwarts,0)
    cx_hp Pico do canal Superado! Novo pico15:7  $+ $readini(picohp.ini,pico,num) $+  0usuários.
  }
}
alias soltar_pris { 
  set %pri.ativo sim
  set %pri $ini(azkaban.ini,$rand(1,$ini(azkaban.ini,0)))
  writeini azkaban.ini %pri hp $readini(azkaban.ini,%pri,hp2)
  msg #Hogwarts 1,1 14,14 07,1 $readini(azkaban.ini,%pri,nome) 0fugiu de Azkaban! 15(0HP:07 $readini(azkaban.ini,%pri,hp2) $+ 15) 14,14 1,1 
  msg #Hogwarts 1,1 14,14 0,1 Para atacá-lo, digite 12@15Atacar 14,14 1,1 
  remini azkaban.ini %pri atacou
  timerfuga 1 180 fugiu_azkaban
}
alias fugiu_azkaban {
  remini azkaban.ini %pri atacou
  msg #Hogwarts 1,1 14,14 07,1 $readini(azkaban.ini,%pri,nome) 0conseguiu fugir! 14,14 1,1 
  /timerlibera 1 18000 //soltar_pris
  set %pri.ativo nao
  unset %pri
}
alias fim_azkaban {
  timerfuga off
  var %atacaram = $readini(azkaban.ini,%pri,atacou)
  var %wd = 1
  var %wd1 = $numtok(%atacaram,32)
  while (%wd <= %wd1) { 
    var %pa = $gettok(%atacaram,%wd,32)
    writeini hp.ini %pa gal $calc($readini(hp.ini,%pa,gal) + $readini(azkaban.ini,%pri,din))
    inc %wd
  }
  remini azkaban.ini %pri atacou
  msg #Hogwarts 1,1 14,14 07,1 $readini(azkaban.ini,%pri,nome) 0foi caputarado e devolvido a Azkaban! Todos que ajudaram na prisão ganharam07 $din_x($readini(azkaban.ini,%pri,din)) 14,14 1,1 
  /timerlibera  1 18000 //soltar_pris
  set %pri.ativo nao
  unset %pri
}
on *:join:#Hogwarts: {
  if ($readini(accesshp.ini,$nick,st) == temp) { remini accesshp.ini $nick }
  if ($readini(hp.ini,$nick,nick) != $null) {
    writeini hp.ini $nick id off
  }
  $check_pico_HP
  if ($nick != $me) {
    ;notice $nick 1,1 15,15 0,1 Bem vindo(a) ao 7#15Hogwarts7,0 para acessar o Bot digite 7@15HP 15,15 1,1 
    var %cas = $readini(hp.ini,$nick,cas)
    if (%cas == corvinal) { var %cr = 11 | var %cass = Corvinal }
    if (%cas == grifinória) { var %cr = 04 | var %cass = Grifinória }
    if (%cas == lufa-lufa) { var %cr = 08 | var %cass = Lufa-Lufa }
    if (%cas == sonserina) { var %cr = 09 | var %cass = Sonserina }
    var %x = 1
    unset %veir
    while (%x <= $ini(%corn,0)) {
      var %cd = $ini(%corn,%x)
      var %re = $readini(%corn,%cd,read)
      if (%re != sim) { set %veir Sim }
      var %x = $calc(%x + 1)
    }
    if (%veir == Sim) { notice $nick 1,1 15,15 0,1 %cr $+ $nick $+ 0, você possui novas mensagens no Corujal. 15,15 1,1  }
  }
}

on *:text:*:#: {
  if ($1 == @iniciar) && ($readini(accesshp.ini,$nick,nv) >= 1) && ($4 != $null) {
    if (# != #Duelos) && (# != #HPArena2) && (# != #HPArena3) { notice $nick 1,1 15,15 0,1 Comando só pode ser na sala de duelos. 15,15 1,1  | halt }
    inicia_duelo $strip($2) $strip($3) $strip($4)
    halt
  }
  if ($1 == @dano) && ($4 != $null) { 
    if ($2 !isnum) { halt }
    if ($3 !isnum) { halt }
    if ($readini(hp.ini,$strip($4),nick) == $null) { cx_ch # $nick não é matriculado. | halt }
    set %s1 $strip($2)
    set %s2 $strip($3)
    set %s3 $strip($4)
    calc_dano
    halt
  }
  if ($1 == @Atacar) && ($chan == #Hogwarts) {
    if (%pri.ativo != sim) { halt }
    if ($readini(hp.ini,$nick,nick) == $null) { halt }
    if ($readini(hp.ini,$nick,vig) == 0) { notice $nick 1,1 14,14 0,1 Você está sem vigor. 14,14 1,1  | halt }
    if ($nick isin $readini(azkaban.ini,%pri,atacou)) { halt }
    var %mag = $readini(hp.ini,$nick,mag)
    var %dano = $int($calc($rand($calc($len(%mag) * $len(%mag)),$calc($len(%mag) * 10)) + (%mag / $replace($len(%mag),2,10,3,100,4,1000,5,10000)) + $len(%mag)))
    writeini azkaban.ini %pri hp $calc($readini(azkaban.ini,%pri,hp) - %dano)
    msg #Hogwarts 1,1 14,14 07,1 $nick 0atacou15 $readini(azkaban.ini,%pri,nome) 0e causou07 %dano 0de dano. 15(0HP:15 $readini(azkaban.ini,%pri,hp) $+ 0/15 $+ $readini(azkaban.ini,%pri,hp2) $+ 15) 14,14 1,1 
    writeini azkaban.ini %pri atacou $nick $readini(azkaban.ini,%pri,atacou)
    var %prob = $rand(1,$readini(azkaban.ini,%pri,prob))
    if (%prob == $readini(azkaban.ini,%pri,prob)) { 
      var %pevig = $rand(1,10)
      writeini hp.ini $nick vig $calc($readini(hp.ini,$nick,vig) - %pevig)
      msg #Hogwarts 1,1 14,14 07,1 $readini(azkaban.ini,%pri,nome) 0contra-ataca07 $nick 0com15 $readini(azkaban.ini,%pri,gop) 0tirando4 %pevig 0de vigor. 14,14 1,1 
    }
    if ($readini(azkaban.ini,%pri,hp) <= 0) { 
      fim_azkaban
    }
    halt
  }
  if ($1 == @Renick) {
    if ($me != Hogwarts) { nick Hogwarts | ns identify 123321 }
  }
  if ($1 == @Aula) && ($readini(accesshp.ini,$nick,nv) >= 4) { //aula.inicio | halt }
  if ($1 == @PararAula) && ($readini(accesshp.ini,$nick,nv) >= 4) { //timernovaaula off | halt }
  if ($1 == @Próxima) { msg #Hogwarts 1,1 14,14 0,1 A próxima 15aula0 será em07 $tempo_certo($timer(novaaula).secs) $+ 0.  14,14 1,1  | halt }
  if ($1 == @hora) { 
    if ($date(HH) >= 00) { var %tie = 14Boa Madruga15! }
    if ($date(HH) >= 06) { var %tie = 14Bom Dia15! }
    if ($date(HH) >= 12) { var %tie = 14Boa Tarde15! }
    if ($date(HH) >= 18) { var %tie = 14Boa Noite15! }
    cx_ch # 7 $+ $nick $+ 15, %tie 00São Exatamente7  $+ $date(HH) $+  15hora14s7  $+ $date(nn) $+  15Minuto14s 0e7  $+ $date(ss) $+  15Segundo14s00. Horário de Manaus 
  }
  if ($1 == @Data) { 
    if ($date(HH) >= 00) { var %tie = 14Boa Madruga15! }
    if ($date(HH) >= 06) { var %tie = 14Bom Dia15! }
    if ($date(HH) >= 12) { var %tie = 14Boa Tarde15! }
    if ($date(HH) >= 18) { var %tie = 14Boa Noite15! }
    if ($date(mm) == 01) { var %mes = Janeiro }
    if ($date(mm) == 02) { var %mes = Fevereiro }
    if ($date(mm) == 03) { var %mes = Março }
    if ($date(mm) == 04) { var %mes = Abril }
    if ($date(mm) == 05) { var %mes = Maio }
    if ($date(mm) == 06) { var %mes = Junho }
    if ($date(mm) == 07) { var %mes = Julho }
    if ($date(mm) == 08) { var %mes = Agosto }
    if ($date(mm) == 09) { var %mes = Setembro }
    if ($date(mm) == 10) { var %mes = Outubro }
    if ($date(mm) == 11) { var %mes = Novembro }
    if ($date(mm) == 12) { var %mes = Dezembro }
    if ($date(ddd) == sun) { var %ds = Domingo }
    if ($date(ddd) == mon) { var %ds = Segunda-Feira }
    if ($date(ddd) == tue) { var %ds = Terça-Feira }
    if ($date(ddd) == wed) { var %ds = Quarta-Feira }
    if ($date(ddd) == thu) { var %ds = Quinta-Feira }
    if ($date(ddd) == fri) { var %ds = Sexta-Feira }
    if ($date(ddd) == sat) { var %ds = Sábado }
    cx_ch # 7 $+ $nick $+ 15,00 %tie 00Data de Hoje14:15 %ds 07 $+ $date(dd) $+  15de7  $+ %mes $+  15de 7 $+ $date(yyyy) $+ 15.
    halt
  }
  if ($1 == @Concentrar) { 
    if ($chan == #H) { notice $nick 1,1 14,14 0,1 Não use esse comando aqui 14,14 1,1  | halt }
    unset %nv2
    hp_expan
    halt
  }
  if ($1 == @livro) {
    if ($readini(book.ini,$strip($2),link) == $null) { notice $nick 1,1 14,14 0,1 Livro não encontrado em nosso acervo 14,14 1,1  | halt }
    else {
      notice $nick 1,1 14,14 0,1 Livro12 $strip($2) - $readini(book.ini,$strip($2),nome) 14,14 1,1 
      notice $nick 1,1 14,14 0,1 Link para Download14:12 $readini(book.ini,$strip($2),link) 14,14 1,1 
    }
    halt
  }
  if ($1 == @Calc) {
    if ($3 isnum) {
      var %magf = $int($calc(($strip($3) * $strip($2)) / 100))
      cx_ch # Calc 15->07 $strip($2) $+ % 0de Magia de15 $strip($3) 00é igual a07 %magf $+ 15.
    halt }
    var %n = $strip($3)
    if ($3 == $null) { var %n = $nick }
    if ($readini(hp.ini,%n,nick) == $null) { cx_ch # %n 0não é matriculado em nossa escola | halt }
    var %mag = $readini(hp.ini,%n,mag)
    var %magf = $int($calc((%mag * $strip($2)) / 100))
    cx_ch # Calc 15->07 $strip($2) $+ % 0da Magia de15 %n 00é igual a07 %magf $+ 15.
    halt
  }
  if ($1 == !atutemp) && ($readini(accesshp.ini,$nick,nv) >= 4) { 
    $checa_logado
    if ($strip($2) !ison #Hogwarts) { notice $nick 1,1 14,14 12,1 $strip($2) 0não está no canal 14,14 1,1  | halt }
    writeini accesshp.ini $strip($2) nv 1
    writeini accesshp.ini $strip($2) st temp
    cx_ch # Usuário12 $strip($2) 0adicionado como12 Atualizador Temporário
    notice $strip($2) 1,1 14,14 0,1 Você foi adicionado como12 Atualizador Temporário 0assim que sair do canal seu acesso será automaticamente retirado 14,14 1,1 
    notice $strip($2) 1,1 14,14 0,1 Para saber os comandos de 12Atualizador Temporário0 digite 12!Access0 no bot 14,14 1,1 
    halt
  }
  if ($1 == !Reg) && ($readini(accesshp.ini,$nick,nv) >= 5) {
    $checa_logado
    if ($readini(hp.ini,$strip($2),mag) == $null) { notice $nick 1,1 14,14 0,1 Nick não cadastrado no banco de dados 14,14 1,1  | halt }
    if ($strip($3) == $null) { notice $nick 1,1 14,14 0,1 Sintaxe incorreta 14,14 1,1  | halt }
    if ($strip($3) > 5) { notice $nick 1,1 14,14 0,1 Nível não pode ser maior que 5 14,14 1,1  | halt }
    if ($strip($3) == 1) { var %cat = 12Atualizador lvl1 }
    if ($strip($3) == 2) { var %cat = 12Atualizador lvl2 }
    if ($strip($3) == 3) { var %cat = 12Operador lvl1 }
    if ($strip($3) == 4) { var %cat = 12Operador lvl2 }
    if ($strip($3) == 5) { var %cat = 12Administrador }
    cx_ch # Usuário12 $strip($2) 0registrado como12 %cat
    notice $strip($2) 1,1 14,14 0,1 Para saber os comandos de um12 %cat 0digite 12!15Access0 no bot 14,14 1,1 
    writeini accesshp.ini $strip($2) nv $strip($3)
    if ($strip($3) >= 1) { chanserv access #Hogwarts add $strip($2) 4 }
    if ($strip($3) >= 3) { chanserv access #Hogwarts add $strip($2) 5 }
    halt
  }
  if ($1 == !Cancelar) && ($readini(accesshp.ini,$nick,nv) >= 3) {
    $checa_logado
    if ($readini(logluta.ini,$strip($2),v) == $null) { notice $nick $logo 5Código7 $strip($2) 5não encontrado. | halt }
    if ($wrap($strip($2), fixedsys, 9, $calc($width(a, fixedsys, 9) * 1), 1) == D) {
      ;vencedor perda
      var %venc = $readini(logluta.ini,$strip($2),v)
      var %vencv = $readini(logluta.ini,$strip($2),vv)
      writeini hp.ini %venc mag $calc($readini(hp.ini,%venc,mag) - 100)
      writeini hp.ini %venc vig $calc($readini(hp.ini,%venc,vig) + %vencv)
      writeini hp.ini %venc vit $calc($readini(hp.ini,%venc,vit) - 1)
      writeini hp.ini %venc gal $calc($readini(hp.ini,%venc,gal) - 160)
      ;perdedor ganho
      var %der = $readini(logluta.ini,$strip($2),d)
      var %derv = $readini(logluta.ini,$strip($2),dv)
      writeini hp.ini %der mag $calc($readini(hp.ini,%der,mag) - 80)
      writeini hp.ini %der vig $calc($readini(hp.ini,%der,vig) + %derv)
      writeini hp.ini %der der $calc($readini(hp.ini,%der,der) - 1)
      writeini hp.ini %der gal $calc($readini(hp.ini,%der,gal) - 140)
      ;narrador ganho
      var %nar = $readini(logluta.ini,$strip($2),n)
      writeini hp.ini %nar nar $calc($readini(hp.ini,%nar,nar) - 1)
      writeini hp.ini %nar gal $calc($readini(hp.ini,%nar,gal) - 190)
      ;deletando log
      remini logluta.ini $strip($2)
      cx_hp Cancelando Duelo - Código07 $strip($2)
      cx_hp 07 $+ %venc 0havia vencido e ficou com07 $replace($bytes($readini(hp.ini,%venc,mag),db),$chr(44),$chr(46)) 0de Magia e $din_x($readini(hp.ini,%venc,gal))
      cx_hp 07 $+ %der 0havia perdido e ficou com07 $replace($bytes($readini(hp.ini,%der,mag),db),$chr(44),$chr(46)) 0de Magia e $din_x($readini(hp.ini,%der,gal))
      cx_hp 07 $+ %nar 0havia narrado e ficou com $din_x($readini(hp.ini,%nar,gal))
      cx_hp Luta Cancelada por07 $nick $+ 0.
      writeini canlog.ini $strip($2) cod $strip($2)
      writeini canlog.ini $strip($2) v %venc
      writeini canlog.ini $strip($2) vv %vencv
      writeini canlog.ini $strip($2) d %der
      writeini canlog.ini $strip($2) dv %derv
      writeini canlog.ini $strip($2) n %nar
      halt
    }
    if ($wrap($strip($2), fixedsys, 9, $calc($width(a, fixedsys, 9) * 1), 1) == E) {
      ;vencedor perda
      var %venc = $readini(logluta.ini,$strip($2),v)
      var %vencv = $readini(logluta.ini,$strip($2),vv)
      writeini hp.ini %venc mag $calc($readini(hp.ini,%venc,mag) - 90)
      writeini hp.ini %venc vig $calc($readini(hp.ini,%venc,vig) + %vencv)
      writeini hp.ini %venc emp $calc($readini(hp.ini,%venc,emp) - 1)
      writeini hp.ini %venc gal $calc($readini(hp.ini,%venc,gal) - 150)
      ;perdedor ganho
      var %der = $readini(logluta.ini,$strip($2),d)
      var %derv = $readini(logluta.ini,$strip($2),dv)
      writeini hp.ini %der mag $calc($readini(hp.ini,%der,mag) - 90)
      writeini hp.ini %der vig $calc($readini(hp.ini,%der,vig) + %derv)
      writeini hp.ini %der emp $calc($readini(hp.ini,%der,emp) - 1)
      writeini hp.ini %der gal $calc($readini(hp.ini,%der,gal) - 150)
      ;narrador ganho
      var %nar = $readini(logluta.ini,$strip($2),n)
      writeini hp.ini %nar nar $calc($readini(hp.ini,%nar,nar) - 1)
      writeini hp.ini %nar gal $calc($readini(hp.ini,%nar,gal) - 190)
      ;deletando log
      var %op = $readini(logluta.ini,$strip($2),op)
      remini logluta.ini $strip($2)
      cx_hp Cancelando Duelo - Código07 $strip($2)
      cx_hp 07 $+ %venc 0ficou com07 $replace($bytes($readini(hp.ini,%venc,mag),db),$chr(44),$chr(46)) 0de Magia e $din_x($readini(hp.ini,%venc,gal))
      cx_hp 07 $+ %der 0ficou com07 $replace($bytes($readini(hp.ini,%der,mag),db),$chr(44),$chr(46)) 0de Magia e $din_x($readini(hp.ini,%der,gal))
      cx_hp 07 $+ %nar 0havia narrado e ficou com $din_x($readini(hp.ini,%nar,gal))
      cx_hp Luta Cancelada por07 $nick $+ 0.
      writeini canlog.ini $strip($2) cod $strip($2)
      writeini canlog.ini $strip($2) v %venc
      writeini canlog.ini $strip($2) vv %vencv
      writeini canlog.ini $strip($2) d %der
      writeini canlog.ini $strip($2) dv %derv
      writeini canlog.ini $strip($2) n %nar
      writeini canlog.ini $strip($2) op %op
      halt
    }
  }
  if ($1 == !Empate) && ($readini(accesshp.ini,$nick,nv) >= 1) {
    $checa_logado
    if ($readini(hp.ini,$strip($2),nick) == $null) { notice $nick $logo 5Aluno7 $strip($2) 5não está matriculado em nossa Escola. | halt }
    if ($readini(hp.ini,$strip($3),nick) == $null) { notice $nick $logo 5Aluno7 $strip($3) 5não está matriculado em nossa Escola. | halt }
    if ($readini(hp.ini,$strip($4),nick) == $null) { notice $nick $logo 5Aluno7 $strip($4) 5não está matriculado em nossa Escola. | halt }
    set %luta1 $strip($2)
    set %luta2 $strip($3)
    set %luta3 $strip($4)
    $check_ala_luta
    var %vig = $rand(1,10)
    ;vencedor ganho
    writeini hp.ini $strip($2) mag $calc($readini(hp.ini,$strip($2),mag) + 90)
    writeini hp.ini $strip($2) vig $calc($readini(hp.ini,$strip($2),vig) - %vig)
    writeini hp.ini $strip($2) emp $calc($readini(hp.ini,$strip($2),emp) + 1)
    writeini hp.ini $strip($2) gal $calc($readini(hp.ini,$strip($2),gal) + 150)
    ;perdedor ganho
    writeini hp.ini $strip($3) mag $calc($readini(hp.ini,$strip($3),mag) + 90)
    writeini hp.ini $strip($3) vig $calc($readini(hp.ini,$strip($3),vig) - %vig)
    writeini hp.ini $strip($3) emp $calc($readini(hp.ini,$strip($3),emp) + 1)
    writeini hp.ini $strip($3) gal $calc($readini(hp.ini,$strip($3),gal) + 150)
    ;narrador ganho
    writeini hp.ini $strip($4) nar $calc($readini(hp.ini,$strip($4),nar) + 1)
    writeini hp.ini $strip($4) gal $calc($readini(hp.ini,$strip($4),gal) + 190)
    ;salvando log
    :repetindo_checagem_do_codigo
    var %cod = $+(E,$rand(0,9),$rand(0,9),$rand(0,9),$rand(0,9))
    if ($readini(logluta.ini,%cod,v) != $null) { goto repetindo_checagem_do_codigo }
    writeini logluta.ini %cod vv %vig
    writeini logluta.ini %cod dv %vig
    writeini logluta.ini %cod v $strip($2)
    writeini logluta.ini %cod d $strip($3)
    writeini logluta.ini %cod n $strip($4)
    writeini logluta.ini %cod op $nick
    cx_hp Atualizando Empate - Código07 %cod
    cx_hp 07 $+ $strip($2) 0ficou com07 $replace($bytes($readini(hp.ini,$strip($2),mag),db),$chr(44),$chr(46)) 0de Magia e $din_x($readini(hp.ini,$strip($2),gal))
    cx_hp 07 $+ $strip($3) 0ficou com07 $replace($bytes($readini(hp.ini,$strip($3),mag),db),$chr(44),$chr(46)) 0de Magia e $din_x($readini(hp.ini,$strip($3),gal))
    cx_hp 07 $+ $strip($4) 0narrou ficando com $din_x($readini(hp.ini,$strip($4),gal))
    cx_hp Luta atualizada por07 $nick $+ 0.
    unset %luta1
    unset %luta2
    unset %luta3
    halt
  }
  if ($1 == !Atualizar) && ($readini(accesshp.ini,$nick,nv) >= 1) {
    $checa_logado
    if ($readini(hp.ini,$strip($2),nick) == $null) { notice $nick $logo 5Aluno7 $strip($2) 5não está matriculado em nossa Escola. | halt }
    if ($readini(hp.ini,$strip($3),nick) == $null) { notice $nick $logo 5Aluno7 $strip($3) 5não está matriculado em nossa Escola. | halt }
    if ($readini(hp.ini,$strip($4),nick) == $null) { notice $nick $logo 5Aluno7 $strip($4) 5não está matriculado em nossa Escola. | halt }
    set %luta1 $strip($2)
    set %luta2 $strip($3)
    set %luta3 $strip($4)
    $check_ala_luta
    ;vencedor ganho
    var %vigv = $rand(1,10)
    writeini hp.ini $strip($2) mag $calc($readini(hp.ini,$strip($2),mag) + 130)
    writeini hp.ini $strip($2) vig $calc($readini(hp.ini,$strip($2),vig) - %vigv)
    writeini hp.ini $strip($2) vit $calc($readini(hp.ini,$strip($2),vit) + 1)
    writeini hp.ini $strip($2) gal $calc($readini(hp.ini,$strip($2),gal) + 160)
    ;perdedor ganho
    var %vigd = $rand(5,15)
    writeini hp.ini $strip($3) mag $calc($readini(hp.ini,$strip($3),mag) + 100)
    writeini hp.ini $strip($3) vig $calc($readini(hp.ini,$strip($3),vig) - %vigd)
    writeini hp.ini $strip($3) der $calc($readini(hp.ini,$strip($3),der) + 1)
    writeini hp.ini $strip($3) gal $calc($readini(hp.ini,$strip($3),gal) + 140)
    ;narrador ganho
    writeini hp.ini $strip($4) nar $calc($readini(hp.ini,$strip($4),nar) + 1)
    writeini hp.ini $strip($4) gal $calc($readini(hp.ini,$strip($4),gal) + 200)
    ;salvando log
    :repetindo_checagem_do_codigo2
    var %cod = $+(D,$rand(0,9),$rand(0,9),$rand(0,9),$rand(0,9))
    if ($readini(logluta.ini,%cod,v) != $null) { goto repetindo_checagem_do_codigo2 }
    writeini logluta.ini %cod vv %vigv
    writeini logluta.ini %cod dv %vigd
    writeini logluta.ini %cod v $strip($2)
    writeini logluta.ini %cod d $strip($3)
    writeini logluta.ini %cod n $strip($4)
    writeini logluta.ini %cod op $nick
    cx_hp Atualizando Duelo - Código07 %cod
    cx_hp 07 $+ $strip($2) 0venceu ficando com07 $replace($bytes($readini(hp.ini,$strip($2),mag),db),$chr(44),$chr(46)) 0de Magia e $din_x($readini(hp.ini,$strip($2),gal))
    cx_hp 07 $+ $strip($3) 0perdeu ficando com07 $replace($bytes($readini(hp.ini,$strip($3),mag),db),$chr(44),$chr(46)) 0de Magia e $din_x($readini(hp.ini,$strip($3),gal))
    cx_hp 07 $+ $strip($4) 0narrou ficando com $din_x($readini(hp.ini,$strip($4),gal))
    cx_hp Luta atualizada por07 $nick $+ 00.
    unset %luta1
    unset %luta2
    unset %luta3
    halt
  }
  if ($1 == @Op) && ($readini(accesshp.ini,$nick,nv) >= 3) {
    $checa_logado
    //mode # +o $nick
    halt
  }
  if ($1 == @DeOp) && ($readini(accesshp.ini,$nick,nv) >= 3) {
    $checa_logado
    //mode # -o $nick
    halt
  }
  if ($1 == @Voice) && ($readini(accesshp.ini,$nick,nv) >= 1) {
    $checa_logado
    //mode # +v $nick
    halt
  }
  if ($1 == @halfop) && ($readini(accesshp.ini,$nick,nv) >= 1) {
    $checa_logado
    //mode # +h $nick
    halt
  }
  if ($1 == @Pico) {
    cx_ch # Pico do canal15:12 $readini(picohp.ini,pico,num) 0users
    halt
  }
  if ($1 == @Recheck) && ($readini(accesshp.ini,$nick,nv) >= 5) {
    $checa_logado
    var %x = 1
    var %gc = 1
    var %cc = 1
    var %sc = 1
    var %lc = 1
    while (%x <= $ini(hp.ini,0)) {
      var %who = $ini(hp.ini,%x)
      if ($readini(hp.ini,%who,cas) == grifinória) { 
        if (%gc == 1) { var %gc = $calc(%gc + 1) | var %grif = %who }
        else { var %gc = $calc(%gc + 1) | var %grif = %grif $+ , $+ %who }
      }
      if ($readini(hp.ini,%who,cas) == sonserina) { 
        if (%sc == 1) { var %sc = $calc(%sc + 1) | var %sons = %who }
        else { var %sc = $calc(%sc + 1) | var %sons = %sons $+ , $+ %who }
      }
      if ($readini(hp.ini,%who,cas) == lufa-lufa) { 
        if (%lc == 1) { var %lc = $calc(%lc + 1) | var %lufa = %who }
        else { var %lc = $calc(%lc + 1) | var %lufa = %lufa $+ , $+ %who }
      }
      if ($readini(hp.ini,%who,cas) == corvinal) { 
        if (%cc == 1) { var %cc = $calc(%cc + 1) | var %corv = %who }
        else { var %cc = $calc(%cc + 1) | var %corv = %corv $+ , $+ %who }
      }
      inc %x
    }
    if (%corv != $null) { writeini casas.ini Corvinal Alunos %corv }
    else { writeini casas.ini Corvinal alunos Nenhum aluno matriculado }
    if (%grif != $null) { writeini casas.ini Grifinória Alunos %grif }
    else { writeini casas.ini grifinória alunos Nenhum aluno matriculado }
    if (%lufa != $null) { writeini casas.ini Lufa-lufa Alunos %lufa }
    else { writeini casas.ini Lufa-lufa alunos Nenhum aluno matriculado }
    if (%sons != $null) { writeini casas.ini Sonserina Alunos %sons }
    else { writeini casas.ini Sonserina alunos Nenhum aluno matriculado }
    cx_ch # Recheck de alunos/casas Completado.
    halt
  }
  if ($1 == @Capturar) {
    var %sor = $rand(1,2)
    if (%sor == 1) { var %a1 = 7 $+ $2 5não está reagindo.7 $nick 5Capturou7 $2 $+ . }
    if (%sor == 2) { var %a1 = A Pokebola explodiu.7 $2 5Escapou. }
    msg $chan $logo 7 $+ $nick 5atira uma pokebola em7 $2 $+ 5. %a1
    halt
  }
  if ($1 == @Matar) {
    var %sor = $rand(1,5)
    if (%sor == 1) { var %a1 = 5e o retalha em milhares de pedacinhos7. }
    if (%sor == 2) { var %a1 = 5e corta o bilau fora7. }
    if (%sor == 3) { var %a1 = 5mas7 $2 5puxa uma escopeta e explode sua cabeça7. }
    if (%sor == 4) { var %a1 = 5mas7 $2 5puxa sua varinha e petrifica7 $nick $+ 5. }
    if (%sor == 5) { var %a1 = 5e arranca a cabeça do infeliz. }
    msg $chan $logo 7 $+ $nick 5puxa uma foice para matar7 $2 $+ 5, %a1
    halt
  }
  if ($1 == !HP) {
    //close -c $nick | //dcc chat $nick | halt 
  }
  if ($1 == @Site) { cx_ch # Site do 7#15Hogwarts15:7 http://Hogwarts.espacogamer.com.br/ | halt } 
  if ($1 == @Twitter) { cx_ch # Siga  o 7#15Hogwarts15:7 http://twitter.com/CH_Hogwarts | halt } 
  if ($1 == @Orkut) { cx_ch # Entre na comunidade do 7#15Hogwarts15:7 http://www.orkut.com.br/Main#Community?cmm=106297912 | halt } 
  if ($1 == @Casa) {
    if ($2 != corvinal) && ($2 != Grifinória) && ($2 != Lufa-lufa) && ($2 != sonserina) { halt }
    var %x = 1
    var %x2 = $ini(hp.ini,0)
    var %x4 = 0
    while (%x <= %x2) {
      var %x3 = $ini(hp.ini,%x)
      if ($readini(hp.ini,%x3,cas) == $2) { var %x4 = $calc(%x4 + 1) }
      inc %x
    }
    if ($2 == corvinal) { var %cr = 12 | var %cr2 = 12,12 | var %cass = Corvinal }
    if ($2 == grifinória) { var %cr = 04 | var %cr2 = 04,04 | var %cass = Grifinória }
    if ($2 == lufa-lufa) { var %cr = 08 | var %cr2 = 08,08 | var %cass = Lufa-Lufa }
    if ($2 == sonserina) { var %cr = 03 | var %cr2 = 03,03 | var %cass = Sonserina }
    msg $chan 1,1 %cr2 0,1 Encontramos %cr $+ %x4 00alunos matriculados na casa %cr $+ %cass %cr2 1,1 
  }
  if ($1 == @new) && ($readini(accesshp.ini,$nick,nv) >= 2) { 
    if ($2 != $null) { 
      $mostra_new($2)
    }
  }
  if ($1 == @Magia) {
    set %nick1 $nick
    if ($2 != $null) { set %nick1 $strip($2) }
    if ($readini(hp.ini,%nick1,nick) == $null) { 
      if (%nick1 == $nick) { notice $nick 1,1 15,15 0,1 Você não é matriculado em nossa escola. 15,15 1,1  | halt }
      if (%nick1 != $nick) { notice $nick 1,1 15,15 7,1 %nick1 0não é matriculado em nossa escola. 15,15 1,1  | halt }
    }
    verify_nivel2
    var %cas = $readini(hp.ini,%nick1,cas)
    if (%cas == corvinal) { var %cr = 11 | var %cr2 = 11,11 | var %cass = Corvinal }
    if (%cas == grifinória) { var %cr = 04 | var %cr2 = 04,04 | var %cass = Grifinória }
    if (%cas == lufa-lufa) { var %cr = 08 | var %cr2 = 08,08 | var %cass = Lufa-Lufa }
    if (%cas == sonserina) { var %cr = 09 | var %cr2 = 09,09 | var %cass = Sonserina }
    msg # 1,1 %cr2 00,01 Magia 15-> %cr $+ %nick1 15( $+ %cr $+ %cass $+ 15) / 0Magia15: %cr $+ $replace($bytes($readini(hp.ini,%nick1,mag),db),$chr(44),$chr(46)) 15(0Nível15: %cr $+ %nv $+ 15) 15/ 0Precisa de mais %cr $+ %falta 0para o Nível %cr $+ $calc(%nv + 1) %cr2 1,1 
    unset %nick
    unset %nv
    unset %falta
    halt
  }
  if ($1 == @Feitiçosdasdasdsads) {
    set %nick1 $nick
    if ($2 != $null) { set %nick1 $strip($2) }
    if ($readini(hp.ini,%nick1,nick) == $null) { 
      if (%nick1 == $nick) { notice $nick 1,1 15,15 0,1 Você não é matriculado em nossa escola. 15,15 1,1  | halt }
      if (%nick1 != $nick) { notice $nick 1,1 15,15 7,1 %nick1 0não é matriculado em nossa escola. 15,15 1,1  | halt }
    }
    verify_nivel2
    var %cas = $readini(hp.ini,%nick1,cas)
    if (%cas == corvinal) { var %cr = 11 | var %cr2 = 11,11 | var %cass = Corvinal }
    if (%cas == grifinória) { var %cr = 04 | var %cr2 = 04,04 | var %cass = Grifinória }
    if (%cas == lufa-lufa) { var %cr = 08 | var %cr2 = 08,08 | var %cass = Lufa-Lufa }
    if (%cas == sonserina) { var %cr = 09 | var %cr2 = 09,09 | var %cass = Sonserina }
    msg # 1,1 %cr2 00,01 Feitiços 15-> %cr $+ %nick1 15( $+ %cr $+ %cass $+ 15) 15-> %cr $+ $replace($readini(hp.ini,%nick1,habil),$chr(44),$chr(44) %cr $+ )  %cr2 1,1 
    unset %nick
    unset %nv
    unset %falta
    halt
  }
  if ($1 == @Enviar) {
    $check_ala_envio($nick,$strip($2))
    var %ni = $nick
    if ($2 != $null) { var %ni = $strip($2) }
    if ($readini(hp.ini,$nick,nick) == $null) { notice $nick 1,1 15,15 7,1 $nick 0não está matriculado em nossa Escola. 15,15 1,1  | halt }
    if ($readini(hp.ini,%ni,nick) == $null) { notice $nick 1,1 15,15 7,1 %ni 0não está matriculado em nossa Escola. 15,15 1,1  | halt }
    set %nick $nick
    $verify_nivel
    var %ama = $readini(hp.ini,$nick,ama)
    if (%ama == $null) { var %ama = Nenhuma }
    var %ani = $readini(hp.ini,$nick,ani)
    if (%ani == $null) { var %ani = Nenhum }
    var %var = $readini(hp.ini,$nick,var)
    if (%var == $null) { var %var = Vá ao Beco diagonal }
    var %ite = $readini(hp.ini,%nd,ite)
    if (%ite == $null) { var %ite = Nenhum }
    notice $nick 1,1 15,15 0,1 Enviando seus dados para7 %ni 15,15 1,1 
    var %cas = $readini(hp.ini,$nick,cas)
    if (%cas == corvinal) { var %cr = 11 | var %cass = Corvinal }
    if (%cas == grifinória) { var %cr = 04 | var %cass = Grifinória }
    if (%cas == lufa-lufa) { var %cr = 08 | var %cass = Lufa-Lufa }
    if (%cas == sonserina) { var %cr = 09 | var %cass = Sonserina }
    msg %ni 1,1 15,15 0,1 Recebendo dados de %cr $+ $nick 15( $+ %cr $+ $readini(hp.ini,$nick,sex) $+ 15) 15,15 1,1 
    msg %ni 1,1 15,15 0,1 Casa15: %cr $+ %cass 14/ 00Magia15: %cr $+ $replace($bytes($readini(hp.ini,$nick,mag),db),$chr(44),$chr(46)) 14/ 00Nível15: %cr $+ %nv 15,15 1,1 
    msg %ni 1,1 15,15 0,1 Animal15: %cr $+ %ani 14/ 00Aptidão Mágica15: %cr $+ %ama 15,15 1,1 
    msg %ni 1,1 15,15 0,1 Varinha15: %cr $+ %var 15,15 1,1 
    msg %ni 1,1 15,15 0,1 Outros15: %cr $+ %ite 15,15 1,1 
    halt
  }
  if ($1 == @Quote) && ($readini(accesshp.ini,$nick,nv) >= 1) {
    $checa_logado
    if ($readini(quote.ini,$strip($2),quo) == $null) { notice $nick $logo 5Quote não encontrada. | halt }
    cx_ch # 15Hogwarts14/11Quotes 1,14 $strip($2) 0,01 $readini(quote.ini,$strip($2),quo)  14,15 14,01 $readini(quote.ini,$strip($2),data)
    halt
  }
  if ($1 == @Quadribol) {
    msg # 1,1 15,15 0,1 Enviando o faq de Quadribol... Aguarde. 15,15 1,1 
    //send $nick Quadribol.pdf
    halt
  }
  if ($1 == @Addon) { halt
    notice $nick 1,1 15,15 0,1 O Addon pode ser baixado através do link15: 15,15 1,1 
    notice $nick 1,1 15,15 15,1 http://www.4shared.com/file/FygHKGQd/_2__MarotoAddon.html 15,15 1,1 
    halt
  }
  if ($1 == @entrar) && ($readini(accesshp.ini,$nick,nv) >= 2) {
    $checa_logado
    join $strip($2)
    halt
  }
  if ($1 == @sair) && ($readini(accesshp.ini,$nick,nv) >= 2) {
    $checa_logado
    //part $strip($2) #Hogwarts
    halt
  }
}
on *:open:=: {
  writeini users.ini $nick ip $chat($nick).ip
  timer $+ $nick $+ conex off
  var %cas = $readini(hp.ini,$nick,cas)
  if (%cas == corvinal) { set %ncor2 11,11 | set %ncor 11 }
  if (%cas == grifinória) { set %ncor2 04,04 | set %ncor 04 }
  if (%cas == lufa-lufa) { set %ncor2 08,08 | set %ncor 08 }
  if (%cas == sonserina) { set %ncor2 09,09 | set %ncor 09 }
  if (%cas == $null) { set %ncor2 15,15 | set %ncor 15 }
  cx_1
  inc_cx 0Bem vindo ao 7#15Hogwarts
  inc_cx 1-
  if ($readini(hp.ini,$nick,nick) == $null) {
    inc_cx Olá7 $nick $+ 0, és novo por aqui. A Escola de Magia e Bruxaria de Hogwarts fica feliz em te ver.
    inc_cx Quer fazer parte da nossa escola?
    inc_cx O Primeiro passo é escolher uma 7Senha0. Ela lhe permitirá a entrada para a escola.
    inc_cx Não escolha uma senha fácil, escolha uma que somente você terá acesso.
    inc_cx Digite uma 7Senha0 agora.
    cx_2
    writeini hp.ini $nick cad1 on
    halt
  } 
  if ($readini(hp.ini,$nick,id) == off) { inc_cx 0[Retrato da Parede] | inc_cx %ncor $+ $nick $+ 0, desejas entrar? Basta me dizer a senha que te deixarei passar. }
  if ($readini(hp.ini,$nick,id) == on) { inc_cx 0Você já está na Sala Comunal de $readini(hp.ini,$nick,cas) | inc_cx 0Digite 7!15Menu 0para ver os comandos do bot }
  cx_2
}
on *:chat:*: {
  var %cas = $readini(hp.ini,$nick,cas)
  if (%cas == corvinal) { set %ncor2 11,11 | set %ncor 11 }
  if (%cas == grifinória) { set %ncor2 04,04 | set %ncor 04 }
  if (%cas == lufa-lufa) { set %ncor2 08,08 | set %ncor 08 }
  if (%cas == sonserina) { set %ncor2 09,09 | set %ncor 09 }
  if (%cas == $null) { set %ncor2 15,15 | set %ncor 15 }
  if ($readini(hp.ini,$nick,nick) == $null) { 
    if ($readini(hp.ini,$nick,cad1) == on) {
      remini hp.ini $nick cad1
      writeini hp.ini $nick sen $strip($1)
      cx_1
      inc_cx 00Senha Registrada!
      inc_cx 07 $+ $strip($1) 0é a sua Senha, Não se esqueça!
      inc_cx 00Agora precisamos saber algumas informações sobre você.
      inc_cx 00Quantos anos você tem?
      cx_2
      writeini hp.ini $nick cad2 on
      halt
    }
    if ($readini(hp.ini,$nick,cad2) == on) {
      if ($strip($1) !isnum) { cx_1 | inc_cx Queremos saber quantos 7anos 0você tem, digite apenas números ok? Vamos, diga sua idade. | cx_2 | halt }
      if ($strip($1) > 30) { cx_1 | inc_cx Nossa, ninguém pode ingressar na Escola de Magia e Bruxaria de Hogwarts com tanta idade assim... Você está brincando comigo não é? Vamos, diga sua idade. | cx_2 | halt }
      remini hp.ini $nick cad2
      writeini hp.ini $nick age $strip($1)
      cx_1
      inc_cx OK! Idade Registrada.
      inc_cx De acordo com o que você disse, você tem7 $strip($1) anos0...
      inc_cx Tudo certo! Agora falta pouco.
      inc_cx Me diga uma coisa, você é um 7Homem 0ou uma 7Mulher0?
      cx_2
      writeini hp.ini $nick cad3 on
      halt
    }
    if ($readini(hp.ini,$nick,cad3) == on) {
      if (*nao sei* iswm $strip($1-)) { cx_1 | inc_cx Vamos, não brinque comigo, você deve saber sim, se você nasceu com um pinto você é um Homem, senão, você é uma Mulher. | inc_cx E Então? O que você é? 7Homem0 ou 7Mulher? | cx_2 | halt }
      if (*não sei* iswm $strip($1-)) { cx_1 | inc_cx Vamos, não brinque comigo, você deve saber sim, se você nasceu com um pinto você é um Homem, senão, você é uma Mulher. | inc_cx E Então? O que você é? 7Homem0 ou 7Mulher? | cx_2 | halt }
      if (*bixa* iswm $strip($1-)) { cx_1 | inc_cx Vamos, essa não é a resposta da pergunta que lhe fiz, digite 7Homem0, essa é a resposta certa para a pergunta. | cx_2 | halt }
      if (*gay* iswm $strip($1-)) { cx_1 | inc_cx Vamos, essa não é a resposta da pergunta que lhe fiz, digite 7Homem0, essa é a resposta certa para a pergunta. | cx_2 | halt }
      if (*bissexual* iswm $strip($1-)) { cx_1 | inc_cx Vamos, essa não é a resposta da pergunta que lhe fiz, digite 7Homem0 ou 7Mulher0, essa é a resposta certa para a pergunta. | cx_2 | halt }
      if (*bi* iswm $strip($1-)) { cx_1 | inc_cx Vamos, essa não é a resposta da pergunta que lhe fiz, digite 7Homem0 ou 7Mulher0, essa é a resposta certa para a pergunta. | cx_2 | halt }
      if (*indeciso* iswm $strip($1-)) { cx_1 | inc_cx Vamos, essa não é a resposta da pergunta que lhe fiz, digite 7Homem0 ou 7Mulher0, essa é a resposta certa para a pergunta. | cx_2 | halt }
      if ($strip($1) != Homem) && ($strip($1) != Mulher) { cx_1 | inc_cx Digite apenas 7Homem 0ou 7Mulher | cx_2 | halt }
      remini hp.ini $nick cad3
      if ($strip($1) == Homem) { var %tip = Bruxo | var %sex = M }
      if ($strip($1) == Mulher) { var %tip = Bruxa | var %sex = F }
      writeini hp.ini $nick bru %tip
      writeini hp.ini $nick sex %sex
      cx_1
      if ($strip($1) == Homem) { inc_cx Ótimo7 $nick $+ 0, tenho certeza que você será um 7Bruxo0 exemplar! }
      if ($strip($1) == Mulher) { inc_cx Ótimo7 $nick $+ 0, tenho certeza que você será uma 7Bruxa0 exemplar! }
      inc_cx 1-
      inc_cx Em uma Cerimônia você caminha dentre vários alunos de Hogwarts, senta-se em uma grande cadeira e colocam um chapéu velho e remendado em sua cabeça.
      cx_2
      chapeu_seletor
      halt
    }
    halt
  }

  ;Após Cadastro, inicio dos comandos bot!!!

  if ($readini(hp.ini,$nick,nick) != $null) { 
    if ($readini(hp.ini,$nick,lob) == sim) {
      var %idb = $readini(banc.ini,$nick,acc)
      var %idb2 = $readini(banc.ini,$nick,sen)
      if (%idb != $strip($1)) { cx_1 | inc_cx 00As informações não batem... Coloque em sequência o identificador e a Senha. | cx_2 | halt }
      if (%idb2 != $strip($2)) { cx_1 | inc_cx 00As informações não batem... Coloque em sequência o identificador e a Senha. | cx_2 | halt }
      writeini hp.ini $nick lob não
      writeini hp.ini $nick lob2 on
      cx_1
      inc_m Banco Gringotes
      inc_cx 1-
      inc_cx Acesso Autorizado!
      inc_cx 0Saldo Atual15: $din_x($readini(banc.ini,$nick,gal))
      inc_cx 1-
      inc_cx Para mais informações digite %ncor $+ !15Conta
      cx_2
      halt
    }
    if ($readini(hp.ini,$nick,id) == off) {
      var %pas = $strip($1)
      if (%pas == $readini(hp.ini,$nick,sen)) {
        writeini hp.ini $nick id On
        var %cos = $readini(hp.ini,$nick,cas)
        writeini hp.ini $nick local Sala Comunal de %cos
        writeini hp.ini $nick ld $date
        writeini hp.ini $nick lh $time
        cx_1
        inc_cx 00[Retrato na Parede]
        inc_cx 00A Senha está correta, pode passar!
        inc_cx 00O Quadro afastou-se e você entrou.
        inc_cx Você está agora na $readini(hp.ini,$nick,local)
        inc_cx 00Digite 7!15Menu 0para ver os comandos do bot.
        cx_2
        var %corn = [ $nick ] $+ .ini
        if ($ini(%corn,0) == 0) { 
          cx_1
          inc_cx Uma coruja se aproxima de você parando em sua frente, de cor pálida, tamanho médio com uma mancha preta ao redor do olho esquerdo.
          inc_cx Você a vê pousando em sua frente, e a mesma após um pio estica uma pata revelando um pergaminho preso.
          inc_cx Ao pegar o pergaminho e abrí-lo você lê:
          inc_cx 1-
          inc_cx "Seja bem vindo à Hogwarts caro estudante, nós do Corujal estamos muito felizes com sua presença.
          inc_cx É um prazer tremendo poder ver que estás aqui. Venha nos visitar e saiba que nossas corujas ficarão felizes em serví-lo!"
          inc_cx Sr. MacHinnegan
          inc_cx 1-
          inc_cx Para visitar o Corujal digite %ncor $+ !15Corujal
          cx_2
        }
      }
      else { cx_1 | inc_cx 00[Retrato na Parede] | inc_cx Creio que não poderei deixá-lo passar, você não disse a chave correta. | cx_2 | halt }
      halt
    }
    if ($strip($1) == !Seção) {
      if ($strip($2) == 1) {
        cx_1
        inc_m Comandos no Chat
        inc_m %ncor $+ ¯¯¯¯¯¯¯¯ ¯¯ ¯¯¯¯
        inc_cx        %ncor $+ !15Access
        inc_cx        %ncor $+ !15Alunos
        inc_cx        %ncor $+ !15Dados
        inc_cx        %ncor $+ !15Feitiço
        inc_cx        %ncor $+ !15News
        inc_cx        %ncor $+ !15Online
        inc_cx        %ncor $+ !15PM
        inc_cx        %ncor $+ !15Quotes
        inc_cx        %ncor $+ !15Top
        inc_cx        %ncor $+ !15Treinar
        cx_2
        halt
      }
      if ($strip($2) == 2) {
        cx_1
        inc_m Comandos em Canais
        inc_m %ncor $+ ¯¯¯¯¯¯¯¯ ¯¯ ¯¯¯¯¯¯
        inc_cx        %ncor $+ @15Casa <Casa>
        inc_cx        %ncor $+ @15Calc <Valor> <Nick>
        inc_cx        %ncor $+ @15Concentrar
        inc_cx        %ncor $+ @15Enviar <Nick>
        inc_cx        %ncor $+ @15Magia <Nick>
        inc_cx        %ncor $+ @15Feitiços <Nick>
        inc_cx        %ncor $+ @15Pico
        cx_2
        halt
      }
      if ($strip($2) == 3) {
        cx_1
        inc_m Serviços
        inc_m %ncor $+ ¯¯¯¯¯¯¯¯
        inc_cx        %ncor $+ !15Beco Diagonal
        inc_cx        %ncor $+ !15Corujal
        inc_cx        %ncor $+ !15Gringotes
        inc_cx        %ncor $+ !15Hogsmeade
        inc_cx        %ncor $+ !15Hogwarts
        cx_2
        halt
      }
      if ($strip($2) == 4) {
        cx_1
        inc_m Arquivos / Downloads
        inc_m %ncor $+ ¯¯¯¯¯¯¯¯ ¯ ¯¯¯¯¯¯¯¯¯
        inc_cx        %ncor $+ @15Quadribol
        inc_cx        %ncor $+ @15Livro <Núm>
        inc_cx        %ncor $+ !15Registros <Nick1> <Nick2>
        cx_2
        halt
      }
    }
    if ($strip($1) == !Secao) {
      if ($strip($2) == 1) {
        cx_1
        inc_m Comandos no Chat
        inc_m %ncor $+ ¯¯¯¯¯¯¯¯ ¯¯ ¯¯¯¯
        inc_cx        %ncor $+ !15Access
        inc_cx        %ncor $+ !15Alunos
        inc_cx        %ncor $+ !15Dados
        inc_cx        %ncor $+ !15News
        inc_cx        %ncor $+ !15Online
        inc_cx        %ncor $+ !15PM
        inc_cx        %ncor $+ !15Quotes
        inc_cx        %ncor $+ !15Top
        inc_cx        %ncor $+ !15Treinar
        cx_2
        halt
      }
      if ($strip($2) == 2) {
        cx_1
        inc_m Comandos em Canais
        inc_m %ncor $+ ¯¯¯¯¯¯¯¯ ¯¯ ¯¯¯¯¯¯
        inc_cx        %ncor $+ @15Casa <Casa>
        inc_cx        %ncor $+ @15Calc <Valor> <Nick>
        inc_cx        %ncor $+ @15Concentrar
        inc_cx        %ncor $+ @15Enviar <Nick>
        inc_cx        %ncor $+ @15Magia <Nick>
        inc_cx        %ncor $+ @15Pico
        cx_2
        halt
      }
      if ($strip($2) == 3) {
        cx_1
        inc_m Serviços
        inc_m %ncor $+ ¯¯¯¯¯¯¯¯
        inc_cx        %ncor $+ !15Beco Diagonal
        inc_cx        %ncor $+ !15Corujal
        inc_cx        %ncor $+ !15Gringotes
        inc_cx        %ncor $+ !15Hogsmeade
        inc_cx        %ncor $+ !15Hogwarts
        cx_2
        halt
      }
      if ($strip($2) == 4) {
        cx_1
        inc_m Arquivos / Downloads
        inc_m %ncor $+ ¯¯¯¯¯¯¯¯ ¯ ¯¯¯¯¯¯¯¯¯
        inc_cx        %ncor $+ @15Livro <Núm>
        inc_cx        %ncor $+ @15Quadribol
        inc_cx        %ncor $+ !15Registros <Nick1> <Nick2>
        cx_2
        halt
      }
    }
    if ($strip($1) == !Post.New) && ($readini(accesshp.ini,$nick,nv) > 3) {
      if ($strip($2-) == $null) { cx_1 | inc_m Coloque o conteúdo da novidade. | cx_2 | halt }
      var %nov = $ini(hpnews.ini,$ini(hpnews.ini,0))
      var %nov = $calc(%nov + 1)
      writeini hpnews.ini %nov data $date
      writeini hpnews.ini %nov hora $time
      writeini hpnews.ini %nov new $strip($2-)
      writeini hpnews.ini %nov por $nick
      cx_1
      inc_cx Novidade Postada! Para ver a novidade digite !New %nov
      cx_2
      halt
    }
    if ($strip($1) == !Del.New) && ($readini(accesshp.ini,$nick,nv) > 2) {
      if ($strip($2) == $null) { cx_1 | inc_m Coloque a New a ser deletada. | cx_2 | halt }
      if ($readini(hpnews.ini,$strip($2),new) == $null) { cx_1 | inc_m Código da novidade inexistente. | cx_2 | halt }
      remini hpnews.ini $strip($2)
      cx_1
      inc_cx Novidade Deletada!
      cx_2
      halt
    }
    if ($strip($1) == !News) {
      var %list = $ini(hpnews.ini,0)
      var %x = 1
      while (%x <= %list) {
        if (%ne == $null) { var %ne = $ini(hpnews.ini,%x) }
        else { var %ne = $ini(hpnews.ini,%x) $+ , $+ %ne }
        inc %x
      }
      cx_1
      inc_m Hogwarts - News
      inc_m %ncor $+ ¯¯¯¯¯¯¯¯ ¯ ¯¯¯¯
      var %x = 1
      while (%x <= 5) {
        var %ni = $gettok(%ne,%x,44)
        var %d = $readini(hpnews.ini,%ni,data)
        var %h = $readini(hpnews.ini,%ni,hora)
        var %a = $readini(hpnews.ini,%ni,por)
        var %new = $readini(hpnews.ini,%ni,new)
        inc_cx 1,15 $+ $+($str($chr(160),$calc(3 - $len(%ni))),%ni) $+ 15,1 $wrap(%new, fixedsys, 9, $calc($width(a, fixedsys, 9) * 45), 1) $+ ...
        inc_cx   15,15 0,1 Por: %ncor $+ %a 14em %ncor $+ %d 14às %ncor $+ %h
        inc_cx 1-
        inc %x
      }
      inc_cx %ncor $+ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
      inc_m Para ver alguma New basta digitar14:
      inc_m %ncor $+ !15New <núm>
      cx_2
      halt
    }
    if ($strip($1) == !new) {
      if ($2 == $null) { cx_1 | inc_m Digite a Novidade | cx_2 | halt }
      if ($readini(hpnews.ini,$strip($2),new) == $null) { cx_1 | inc_m New não encontrada | cx_2 | halt }
      cx_1
      inc_m Hogwarts - News
      inc_m %ncor $+ ¯¯¯¯¯¯¯¯ ¯ ¯¯¯¯
      inc_m 14" $+ 15New nº  $+ %ncor $+ $strip($2) $+ 14"
      inc_cx 1-
      inc_cx %ncor $+ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
      inc_cx $readini(hpnews.ini,$strip($2),new)
      inc_cx 1-
      inc_cx %ncor $+ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
      inc_m Postada por15 $readini(hpnews.ini,$strip($2),por) 0em14 $readini(hpnews.ini,$strip($2),data) 0às14 $readini(hpnews.ini,$strip($2),hora)
      cx_2
      halt
    }
    if ($strip($1) == !registros) {
      if ($3 == $null) { cx_1 | inc_cx Sintaxe incorreta. !Registros <nick1> <nick2> | cx_2 | halt }
      set %nick1 $strip($2)
      set %nick2 $strip($3)
      ver_luta 
      unset %nick1
      unset %nick2
      halt
    }
    if ($strip($1) == !reg.cancel) && ($nick == Memory) {
      if ($3 == $null) { cx_1 | inc_cx Sintaxe incorreta. !Registros <nick1> <nick2> | cx_2 | halt }
      set %nick1 $strip($2)
      set %nick2 $strip($3)
      can_luta 
      unset %nick1
      unset %nick2
      halt
    }
    if ($strip($1) == !evento) && ($2 != $null) { 
      if ($readini(hpatu.ini,$strip($2),tipo) == $null) { cx_1 | inc_m Evento não encontrado | cx_2 | halt }
      var %eve = $strip($2)
      var %tipo = $readini(hpatu.ini,%eve,tipo)
      if (%tipo == rpg) {
        var %notas = $readini(hpatu.ini,%eve,notas)
        var %nnic = $numtok(%notas,42)
        var %x = 1
        cx_1
        inc_m Hogwarts - Evento
        inc_m %ncor $+ ¯¯¯¯¯¯¯¯ ¯ ¯¯¯¯¯¯
        inc_m 14"15 $+ $readini(hpatu.ini,%eve,tit) $+ 14"
        inc_cx 1-
        inc_cx %ncor $+ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
        inc_cx                       Mestre14:15 $gettok($readini(hpatu.ini,%eve,nar),1,32)
        inc_cx                      Duração14:15 $readini(hpatu.ini,%eve,durou)
        inc_cx                  Responsável14:15 $readini(hpatu.ini,%eve,resp)
        inc_cx                 Realizado em14:15 $readini(hpatu.ini,%eve,data2)
        inc_cx 1-
        inc_cx %ncor $+ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
        inc_cx     14Bruxos             Nota      +Magia      +Nuques
        while (%x <= %nnic) {
          var %magi = $int($calc(($gettok($gettok(%notas,%x,42),2,32) * 50) * 2.5))
          inc_cx     $gettok($gettok(%notas,%x,42),1,32) $+ $str($chr(160),$calc(19 - $len($gettok($gettok(%notas,%x,42),1,32)))) 15 $+ $gettok($gettok(%notas,%x,42),2,32)       00 $+ $+(%magi,$str($chr(160),$calc(11 - $len(%magi)))) 15 $+ $calc($gettok($gettok(%notas,%x,42),2,32) * 110)
          inc %x
        }
        inc_cx 1-
        inc_cx     14Mestre             Nota      +Nuques
        inc_cx     $gettok($readini(hpatu.ini,%eve,nar),1,32) $+ $str($chr(160),$calc(19 - $len($gettok($readini(hpatu.ini,%eve,nar),1,32)))) 15 $+ $gettok($readini(hpatu.ini,%eve,nar),2,32)       00 $+ $int($calc($gettok($readini(hpatu.ini,%eve,nar),2,32) * 110))
        inc_cx 1-
        inc_cx %ncor $+ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
        inc_m 14Observações aos Participantes
        inc_m2 $readini(hpatu.ini,%eve,obsp)
        inc_cx 1-
        inc_m 14Observações ao Mestre
        inc_m2 $readini(hpatu.ini,%eve,obsn)
        inc_cx 1-
        inc_m 14Observações Gerais
        inc_m2 $readini(hpatu.ini,%eve,obs)
        inc_cx 1-
        inc_cx %ncor $+ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
        inc_m postado por14 $readini(hpatu.ini,%eve,por) 0em14 $readini(hpatu.ini,%eve,data) 0às14 $readini(hpatu.ini,%eve,hora)
        cx_2
      }
      halt
    }
    if ($strip($1) == !Menu) {
      cx_1
      inc_m Menu de Ajuda
      inc_m %ncor $+ ¯¯¯¯ ¯¯ ¯¯¯¯¯
      inc_m 15Dividimos os comandos do bot em %ncor $+ 4 15Seções.
      inc_m 15São elas:
      inc_cx 1-
      inc_cx          %ncor $+ !15Seção %ncor $+ 1 0- 15Seção de Comandos no Chat
      inc_cx          %ncor $+ !15Seção %ncor $+ 2 0- 15Seção de Comandos em Canais
      inc_cx          %ncor $+ !15Seção %ncor $+ 3 0- 15Seção de Serviços
      inc_cx          %ncor $+ !15Seção %ncor $+ 4 0- 15Seção de Arquivos e Downloads
      inc_cx 1-
      inc_m %ncor $+ ! 0- 15Comandos utilizados no Chat
      inc_m %ncor $+ @ 0- 15Comandos utilizados no Canal
      cx_2
      halt
    }
    if ($strip($1) == !Itip) && ($readini(accesshp.ini,$nick,nv) >= 4) { 
      if ($3 == $null) { cx_1 | inc_cx Sintaxe incorreta, coloque %ncor $+ !15Tip.it %ncor $+ '15Tipo $+ %ncor $+ ' '15Item $+ %ncor $+ ' | cx_2 | halt }
      writeini loja.ini $replace($$3-,$chr(32),$chr(46)) tip $strip($2)
      cx_1 
      inc_cx Tipo alterado para o item  $+ %ncor $+ $strip($3-) $+ 
      inc_cx Novo tipo15: %ncor $+ $strip($2) 
      cx_2
    }
    if ($strip($1) == !Bônus) && ($readini(accesshp.ini,$nick,nv) >= 4) { 
      if ($4 !isnum) { cx_1 | inc_m Coloque um valor numérico. | cx_2 | halt }
      if ($4 == $null) { cx_1 | inc_cx Sintaxe incorreta. %ncor $+ !15Bônus <nick> <atributo> <valor> | cx_2 | halt }
      if ($readini(hp.ini,$strip($2),nick) == $null) { cx_1 | inc_cx O aluno %ncor $+ $strip($2) 0não está matriculado em nossa escola. | cx_2 | halt }
      if ($strip($3) == Dinheiro) { var %mud = gal }
      else if ($strip($3) == Magia) { var %mud = mag }
      else if ($strip($3) == Vigor) { var %mud = vig }
      else { cx_1 | inc_m Atributo inexistente | cx_2 | halt }
      var %ant = $readini(hp.ini,$strip($2),%mud)
      writeini  hp.ini $strip($2) %mud $calc(%ant + $strip($4))
      cx_1
      inc_m Bônus
      inc_cx Nick Bonificado15: %ncor $+ $readini(hp.ini,$strip($2),nick)
      inc_cx Atributo15: %ncor $+ $strip($3)
      inc_cx Quantidade15: %ncor $+ $strip($4)
      cx_2
      halt
    } 
    if ($strip($1) == !Top) { 
      if ($2 == $null) { var %top = 10 }
      if ($strip($2) != $null) { var %top = $strip($2) }
      if ($strip($2) > 20) { cx_1 | inc_m Top máximo15: %ncor $+ !15Top 20 | cx_2 | halt }
      if (%top > $ini(hp.ini,0)) { var %top = $ini(hp.ini,0) }
      var %top_hp = 1
      var %top_hp2 = %top
      cx_1
      inc_m Hogwarts Top $+ %top
      inc_m %ncor $+ ¯¯¯¯¯¯¯¯ ¯¯¯ $+ $replace($len(%top),1,¯,2,¯¯)
      inc_cx %ncor $+ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
      inc_cx 14  Top Nick                      Magia         Nível
      while (%top_hp <= $ini(hp.ini,0)) {
        var %nick_top = $ini(hp.ini,%top_hp)
        if ($readini(hp.ini,%nick_top,mag) > 150) {
          if (%top_hp == 0) { var %'1 = $readini(hp.ini,%nick_top,mag) %nick_top }
          else { var %'1 = $readini(hp.ini,%nick_top,mag) %nick_top $+ , $+ %'1 }
        }
        inc %top_hp
      }
      var %'1 = $sorttok(%'1,44,nr)
      var %top_hp = 1
      while (%top_hp <= %top) {
        var %nick_top = $gettok($gettok(%'1,%top_hp,44),2,32)
        var %mag_top = $gettok($gettok(%'1,%top_hp,44),1,32)
        var %cor_hp = $replace($readini(hp.ini,%nick_top,cas),corvinal,11,grifinória,04,lufa-lufa,08,sonserina,09)
        inc_cx 14 $+ $str($chr(160),$calc(4 - $len(%top_hp))) $+ %top_hp $+ º %cor_hp $+ %nick_top $+ $str($chr(160),$calc(25 - $len(%nick_top))) 15 $+ $replace($bytes(%mag_top,db),$chr(44),$chr(46)) $+ $str($chr(160),$calc(14 - $len($replace($bytes(%mag_top,db),$chr(44),$chr(46))))) 00 $+ $check_nivel(%mag_top)
        inc %top_hp
      }
      cx_2
      halt
    }
    if ($strip($1) == !access) && ($readini(accesshp.ini,$nick,nv) >= 1) {
      cx_1
      inc_m Hogwarts - Staff
      inc_cx 1-
      if ($readini(accesshp.ini,$nick,nv) >= 1) { 
        inc_cx 8@15Iniciar <8bruxo115> <8bruxo215> <8narrador15> 
        inc_cx Inicia um Duelo entre bruxo1 e bruxo2 narrado pelo narrador
        inc_cx 1-
        inc_cx 8@15Voice 
        inc_cx Pega + no canal pedido.
        inc_cx 1-
        inc_cx 8@15Quote <8número15>
        inc_cx Mostra a quote número no canal.
        inc_cx 1-
        inc_cx 8!15Atualizar <8vencedor15> <8perdedor15> <8narrador15>
        inc_cx Atualiza um duelo.
        inc_cx 1-
        inc_cx 8!15Empate <8bruxo115> <8bruxo215> <8narrador15>
        inc_cx Atualiza um empate.
        inc_cx 1-
      }
      if ($readini(accesshp.ini,$nick,nv) >= 2) { 
        inc_cx 8@15Entrar <8#Canal15>
        inc_cx Faz o bot entrar no #Canal informado.
        inc_cx 1-
        inc_cx 8@15Sair <8#Canal15>
        inc_cx Faz o bot sair do #Canal informado.
        inc_cx 1-
        inc_cx 12!15Quote <12ADD/DEL15> <12quote15/12número15>
        inc_cx Adiciona/Deleta uma quote.
        inc_cx 1-
      }
      if ($readini(accesshp.ini,$nick,nv) >= 3) { 
        inc_cx 12!15Pontos <12casa15> <12nick15> <12+valor15>
        inc_cx Adiciona pontos ganhos por nick para a casa informada.
        inc_cx 1-
        inc_cx 12!15Pontos <12casa15> <12nick15> <12-valor15>
        inc_cx Retira pontos perdidos por nick para a casa informada.
        inc_cx 1-
        inc_cx 12!15Aula.hora <12matéria15> <12horário115>
        inc_cx Altera a data/hora da matéria informada.
        inc_cx 1-
        inc_cx 12!15Post.New <12novidade15>
        inc_cx Posta uma novidade no bot
        inc_cx 1-
        inc_cx 12!15Del.New <12num15>
        inc_cx Deleta a novidade informada
        inc_cx 1-
        inc_cx 8!15Cancelar <8código15>
        inc_cx Cancela um duelo anterior.
        inc_cx 1-
        inc_cx 8@15Op 
        inc_cx Pega @ no canal pedido.
        inc_cx 1-
        inc_cx 8@15New <8num15>
        inc_cx Mostra a New informada.
        inc_cx 1-
      }
      if ($readini(accesshp.ini,$nick,nv) >= 4) { 
        inc_cx 8!15AtuTemp <8nick15>
        inc_cx Adiciona o nick como Atualizador temporário.
        inc_cx 1-
        inc_cx 12!15Set <12cargo15> <12casa15/12matéria15> <12nick15>
        inc_cx Adiciona ao nick um cargo na Casa/Matéria informada.
        inc_cx 1-
        inc_cx 12!15Unset <12cargo15> <12casa15/12matéria15> <12nick15>
        inc_cx Retira o cargo do nick da Casa/Matéria informada.
        inc_cx 1-
        inc_cx 12!15Cargo <12nick15> <12cargo15>
        inc_cx Altera o cargo do nick informado.
        inc_cx 1-
        inc_cx 12!15Itip <12tipo15> <12item15>
        inc_cx Altera o tipo do item informado.
        inc_cx 1-
      }
      if ($readini(accesshp.ini,$nick,nv) >= 5) { 
        inc_cx 12!15Chat <12on15/12off15>
        inc_cx Ativa/Desativa o chat geral no bot.
        inc_cx 1-
        inc_cx 12!15KM <12mensagem15>
        inc_cx Envia uma mensagem global para todos no chat.
        inc_cx 1-
        inc_cx 12!15Del <12nick15>
        inc_cx Desmatricula o nick informado.
        inc_cx 1-
      }
      inc_cx Os Comandos em 12AZUL0 são utilizados no bot
      inc_cx Os Comandos em 08AMARELO0 são utilizados em canais
      cx_2
      halt
    }
    if ($strip($1) == !Alunos) {
      if ($readini(casas.ini,$strip($2),alunos) == $null) { cx_1 | inc_cx Casa inexistente em nossa Escola. | cx_2 | halt }
      if ($strip($2) == corvinal) { var %cr = 11 | var %cass = Corvinal }
      if ($strip($2) == grifinória) { var %cr = 04 | var %cass = Grifinória }
      if ($strip($2) == lufa-lufa) { var %cr = 08 | var %cass = Lufa-Lufa }
      if ($strip($2) == sonserina) { var %cr = 09 | var %cass = Sonserina }
      cx_1
      inc_cx Alunos Matriculados na Casa %cr $+ %cass
      inc_cx 1-
      inc_cx $readini(casas.ini,%cass,alunos)
      cx_2
      halt
    }
    if ($strip($1) == !Dados) { 
      if ($2 == $null) { set %nd $nick }
      if ($2 != $null) { set %nd $2 }
      if ($readini(hp.ini,%nd,nick) == $null) { inc_cx %nd 0não está matriculado. | halt }
      set %ndd $nick
      $dados_hp 
      halt 
    }
    if ($strip($1) == !Ala) && ($strip($2) == Hospitalar) { $check_ala_hp }
    if ($strip($1) == !online) { set %nhp $nick | $online_hp | halt }
    if ($strip($1) == !KM) && ($readini(accesshp.ini,$nick,nv) >= 5) { set %fala $strip($2-) | all_hp | halt }
    if ($strip($1) == !PM) { set %nick.pm $strip($2) | set %fala $strip($3-) | pm_hp | halt }
    if ($strip($1) == !Chat) && ($readini(accesshp.ini,$nick,nv) >= 3) { set %chat.free $strip($2) | cx_1 | inc_cx Status do chat15: %ncor $+ %chat.free | cx_2 | halt }
    if ($strip($1) == !Gringotes) { banco_hp | halt }
    if ($strip($1) == !Abrir) && ($strip($2) == conta) { abrir_conta | halt }
    if ($strip($1) == !Acessar) && ($strip($2) == conta) { acessar_conta | halt }
    if ($strip($1) == !Depositar) { 
      if ($readini(hp.ini,$nick,lob2) != on) { cx_1 | inc_cx Você precisa acessar sua conta primeiro. | cx_2 | halt }
      var %gal1 = $readini(hp.ini,$nick,gal)
      if ($strip($2) > %gal1) { cx_1 | inc_cx Você não possui essa quantia de Galeões. | cx_2 | halt }
      if (+ isin $strip($1-)) { halt } 
      if (- isin $strip($1-)) { halt } 
      if ($strip($2) !isnum) { halt } 
      var %gal2 = $readini(banc.ini,$nick,gal)
      writeini hp.ini $nick gal $calc(%gal1 - $strip($2))
      writeini banc.ini $nick lasd $strip($2)
      writeini banc.ini $nick gal $calc(%gal2 + $strip($2))
      cx_1
      inc_m Banco Gringotes
      inc_cx 1-
      inc_cx Depósito efetuado
      inc_cx Seu novo saldo no Banco Gringotes é $din_x($readini(banc.ini,$nick,gal))
      inc_cx E em mãos você possui $din_x($readini(hp.ini,$nick,gal))
      cx_2
      halt
    }
    if ($strip($1) == !Retirar) { 
      if ($readini(hp.ini,$nick,lob2) != on) { cx_1 | inc_cx Você precisa acessar sua conta primeiro. | cx_2 | halt }
      var %gal2 = $readini(banc.ini,$nick,gal)
      if ($strip($2) > %gal2) { cx_1 | inc_cx Você não possui essa quantia de Galeões. | cx_2 | halt }
      if (+ isin $strip($1-)) { halt } 
      if (- isin $strip($1-)) { halt } 
      if ($strip($2) !isnum) { halt } 
      var %gal1 = $readini(hp.ini,$nick,gal)
      writeini hp.ini $nick gal $calc(%gal1 + $strip($2))
      writeini banc.ini $nick lasr $strip($2)
      writeini banc.ini $nick gal $calc(%gal2 - $strip($2))
      cx_1
      inc_m Banco Gringotes
      inc_cx 1-
      inc_cx Saque efetuado.
      inc_cx Seu novo saldo no Banco Gringotes é $din_x($readini(banc.ini,$nick,gal))
      inc_cx E em mãos você possui $din_x($readini(hp.ini,$nick,gal))
      cx_2
      halt
    }
    if ($strip($1) == !Conta) { 
      if ($readini(hp.ini,$nick,lob2) != on) { cx_1 | inc_cx Você precisa acessar sua conta primeiro. | cx_2 | halt }
      var %last = $readini(banc.ini,$nick,last)
      var %last2 = $readini(banc.ini,$nick,last2)
      if (%last != $null) { var %last %last 5( $+ %cr $+ %last2 $+ 5) }
      if (%last == $null) { var %last = Não Registrada }
      var %lasr = $readini(banc.ini,$nick,lasr)
      if (%lasr == $null) { var %lasr = Não Registrada }
      cx_1
      inc_m Banco Gringotes
      inc_cx 1-
      inc_m 14Data atual $date
      inc_cx 1-
      inc_cx Identificador15: %ncor $+ $readini(banc.ini,$nick,acc)
      inc_cx Saldo15: $din_x($readini(banc.ini,$nick,gal))
      inc_cx Último Depósito15: $din_x($readini(banc.ini,$nick,lasd))
      inc_cx Última Retirada15: $din_x(%lasr)
      inc_cx Última Tranferência15: $din_x($gettok(%last,1,32)) 14 $+ $strip($gettok(%last,2,32))
      cx_2
      halt
    }
    if ($strip($1) == !Transferir) { 
      if ($strip($2) == $nick) { cx_1 | inc_cx Não transfira pra você mesmo. | cx_2 | halt }
      if ($readini(hp.ini,$nick,lob2) != on) { cx_1 | inc_cx Você precisa acessar sua conta primeiro. | cx_2 | halt }
      if ($readini(hp.ini,$strip($2),nick) == $null) { cx_1 | inc_cx O bruxo(a) informado não está matriculado em nossa escola. | cx_2 | halt }
      if ($readini(banc.ini,$strip($2),nick) == $null) { cx_1 | inc_cx O bruxo(a) informado não possui conta no Banco Gringotes. | cx_2 | halt }
      if ($readini(banc.ini,$nick,gal) < $strip($3)) { cx_1 | inc_cx Você não possui a quantia de Galeões em sua conta. | cx_2 | halt }
      if (+ isin $strip($1-)) { halt } 
      if (- isin $strip($1-)) { halt } 
      if ($strip($3) !isnum) { halt } 
      writeini banc.ini $strip($2) gal $calc($readini(banc.ini,$strip($2),gal) + $strip($3))
      writeini banc.ini $nick gal $calc($readini(banc.ini,$strip($2),gal) - $strip($3))
      cx_1
      inc_cx Transferência efetuada com sucesso.
      inc_cx Seu novo saldo é de $din_x($readini(banc.ini,$nick,gal))
      cx_2
      msg $strip($2) 1,1 15,15 0,1 Você recebeu uma transferência no valor de $din_x($strip($3)) 0de %ncor $+ $nick 14( $+ $strip($3) nuques) 15,15 1,1 
      writeini banc.ini $nick last $strip($3) 
      writeini banc.ini $nick last2 $strip($2)
      halt
    }
    if ($strip($1) == !View) && ($strip($2) != $null) {
      $cod_luta($strip($2))
      halt
    }
    if ($strip($1) == !Treinar) {
      if ($readini(hp.ini,$nick,treino) == $date) { cx_1 | inc_cx Você já realizou seu treino hoje. | cx_2 | halt }
      if ($readini(hp.ini,$nick,treinando) == sim) { cx_1 | inc_cx Você está treinando. | cx_2 | halt }
      $check_treino_vig
      set %nick $nick
      $treino_hp
      halt
    }
    if ($strip($1) == !Cargo) && ($readini(accesshp.ini,$nick,nv) >= 4) {
      writeini hp.ini $strip($2) car $strip($3-)
      cx_1
      inc_m Alteração de Cargo
      inc_cx 1-
      inc_cx Nick15: %ncor $+ $readini(hp.ini,$strip($2),nick)
      inc_cx Novo cargo15: %ncor $+ $strip($3-)
      cx_2
      halt
    }
    if ($strip($1) == !Hogwarts) {
      var %whi = 2
      while (%whi <= 5) {
        if (%whi == 2) { var %c'_ = $readini(casas.ini,$ini(casas.ini,%whi),pontos) $ini(casas.ini,%whi) }
        else { var %c'_ = %c'_ $+ , $+ $readini(casas.ini,$ini(casas.ini,%whi),pontos) $ini(casas.ini,%whi) }
        inc %whi
      }
      var %c'_ = $sorttok(%c'_,44,nr)
      var %cor1 = $replace($gettok($gettok(%c'_,1,44),2,32),grifinória,04,corvinal,11,lufa-lufa,08,sonserina,09)
      var %cor2 = $replace($gettok($gettok(%c'_,2,44),2,32),grifinória,04,corvinal,11,lufa-lufa,08,sonserina,09)
      var %cor3 = $replace($gettok($gettok(%c'_,3,44),2,32),grifinória,04,corvinal,11,lufa-lufa,08,sonserina,09)
      var %cor4 = $replace($gettok($gettok(%c'_,4,44),2,32),grifinória,04,corvinal,11,lufa-lufa,08,sonserina,09)
      var %p_1 = %cor1 $+ ,15 $+ $+($str($chr(160),$ceil($calc(4 - $calc(($len($gettok($gettok(%c'_,1,44),1,32)) + 1) / 2)))),$gettok($gettok(%c'_,1,44),1,32),14p,$str($chr(160),$floor($calc(4 - $calc(($len($gettok($gettok(%c'_,1,44),1,32)) + 1) / 2)))))
      var %p_2 = %cor2 $+ ,15 $+ $+($str($chr(160),$ceil($calc(4 - $calc(($len($gettok($gettok(%c'_,2,44),1,32)) + 1) / 2)))),$gettok($gettok(%c'_,2,44),1,32),14p,$str($chr(160),$floor($calc(4 - $calc(($len($gettok($gettok(%c'_,2,44),1,32)) + 1) / 2)))))
      var %p_3 = %cor3 $+ ,15 $+ $+($str($chr(160),$ceil($calc(4 - $calc(($len($gettok($gettok(%c'_,3,44),1,32)) + 1) / 2)))),$gettok($gettok(%c'_,3,44),1,32),14p,$str($chr(160),$floor($calc(4 - $calc(($len($gettok($gettok(%c'_,3,44),1,32)) + 1) / 2)))))
      var %p_4 = %cor4 $+ ,15 $+ $+($str($chr(160),$ceil($calc(4 - $calc(($len($gettok($gettok(%c'_,4,44),1,32)) + 1) / 2)))),$gettok($gettok(%c'_,4,44),1,32),14p,$str($chr(160),$floor($calc(4 - $calc(($len($gettok($gettok(%c'_,4,44),1,32)) + 1) / 2)))))
      var %n_1 = %cor1 $+ $+($str($chr(160),$ceil($calc(6 - $calc($len($gettok($gettok(%c'_,1,44),2,32)) / 2)))),$gettok($gettok(%c'_,1,44),2,32),$str($chr(160),$floor($calc(6 - $calc($len($gettok($gettok(%c'_,1,44),2,32)) / 2)))))
      var %n_2 = %cor2 $+ $+($str($chr(160),$ceil($calc(6 - $calc($len($gettok($gettok(%c'_,2,44),2,32)) / 2)))),$gettok($gettok(%c'_,2,44),2,32),$str($chr(160),$floor($calc(6 - $calc($len($gettok($gettok(%c'_,2,44),2,32)) / 2)))))
      var %n_3 = %cor3 $+ $+($str($chr(160),$ceil($calc(6 - $calc($len($gettok($gettok(%c'_,3,44),2,32)) / 2)))),$gettok($gettok(%c'_,3,44),2,32),$str($chr(160),$floor($calc(6 - $calc($len($gettok($gettok(%c'_,3,44),2,32)) / 2)))))
      var %n_4 = %cor4 $+ $+($str($chr(160),$ceil($calc(6 - $calc($len($gettok($gettok(%c'_,4,44),2,32)) / 2)))),$gettok($gettok(%c'_,4,44),2,32),$str($chr(160),$floor($calc(6 - $calc($len($gettok($gettok(%c'_,4,44),2,32)) / 2)))))
      cx_1
      inc_m Hogwarts
      inc_cx 1-
      inc_cx %ncor $+ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
      inc_cx     %n_1 %n_2 %n_3 %n_4
      inc_cx       15________     ________     ________     ________ 
      inc_cx      15| $+ %cor1 $+ '~'~    15|   |        15|   |        15|   |        15|
      inc_cx      15| $+ %cor1 $+ ~'~'~'~'15|   |        15|   |        15|   |        15|
      inc_cx       15\ $+ %cor1 $+ ~'~'~'15/     \ $+ %cor2 $+ ~'~'~ 15/     \      15/     \      15/
      inc_cx       1,00 $+ %p_1 $+ 1,1     1,00 $+ %p_2 $+ 1,1     1,00 $+ %p_3 $+ 1,1     1,00 $+ %p_4 $+ 1,1    
      inc_cx       15/ $+ %cor1 $+ '~'~'~15\     / $+ %cor2 $+ '~'~'~15\     / $+ %cor3 $+ '~'~  15\     /      15\
      inc_cx      15| $+ %cor1 $+ '~'~'~'~15|   | $+ %cor2 $+ '~'~'~'~15|   | $+ %cor3 $+ '~'~'~'~15|   | $+ %cor4 $+   '~    15|
      inc_cx      15| $+ %cor1 $+ ~'~'~'~'15|   | $+ %cor2 $+ ~'~'~'~'15|   | $+ %cor3 $+ ~'~'~'~'15|   | $+ %cor4 $+ ~'~'~'~'15|
      inc_cx       15¯¯¯¯¯¯¯¯     ¯¯¯¯¯¯¯¯     ¯¯¯¯¯¯¯¯     ¯¯¯¯¯¯¯¯
      inc_cx          1º           2º           3º           4º 
      inc_cx 1-
      if ($gettok($gettok(%c'_,1,44),2,32) == Grifinória) {
        inc_cx 8,8¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯1,1
        inc_cx 1-
        inc_cx      0/\4/\0/\4/\0/\4/\0/\4/\0/\4/\0/\4/\ 4,4/\/\/\/\/\/\/\/\/\/\/\/\0,1
        inc_cx      0\/4\/0\/4\/0\/4\/0\/4\/0\5,1.'¯¯¯¯¯\4,4/\/\/\/\/\/\/\/\/\      0,1
        inc_cx      4/\0/\4/\0/\4/\0/\4/\0/\5,1·     8,1/¯-¯¯¯|\4,4/\/\/\/\/\/        0,1
        inc_cx      4\/0\/4\/0\/4\/0\/4\/0\5,1/     8,1/       /4,4/\/\/\/\/\/        0,1
        inc_cx      0/\4/\0/\4/\0/\4/\0/\5,1/    8,1/¯   /8,4¯¯8,1\|4,4/\/\/\/\/\/\/\/     0,1                
        inc_cx      0\/4\/0\/4\/0\/4\/0\5,1.     8,1\'   |4,4            8,1/¯¯¯/4,4/\/\/\/0,1
        inc_cx      4/\0/\4/\0/\4/\0/\4/5,1;      8,1¯\   ¯¯¯¯|4,4      8,1/   /4,4/\/\/   0,1
        inc_cx      4\/0\/4\/0\/4\/0\/4\5,1'        8,1\     /4,4      8,1/  /8,4¯4,4/\/\/\/\/0,1
        inc_cx      0/\4/\0/\4/\0/\4/\0/\5,1\        8,1¯¯¯¯¯5,1\4,4     8,1/  /4,4/\/\/\/\/  0,1
        inc_cx      0\/4\/0\/4\/0\/4\/0\/ 5,1\             5,1\4,4   8,1/  8,1/4,4/\/\/\/\/\/\0,1
        inc_cx      4/\0/\4/5,1_0/\4/\0/\4/\0/\5,1\  /'·.       \4,4 8,1/  8,1/4,4/\/\/\/\/\/  0,1
        inc_cx      4\/0\/5,5|;;5\4,1\/0\/4\/0\/ 5,1|/   8,1\5,1'_.     \  8,1|4,4/\/\/\        0,1
        inc_cx      0/\4/\0/5,5\/8,1\\4 /\0/\4/\ 8,1|     \  5,1''-___\8,1/4,4/\/\/\/\/\     0,1
        inc_cx      0\/4\/0\/4\/8,1\\4\/0\/4\/ 8,1|      ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\4,4/\/\/\/\/0,1
        inc_cx      4,4         8,1||4,4      8,1|                ____  \4/\0/\4/\0/\
        inc_cx      4,4         8,1||4,4       8,1\  \|/¯¯¯¯¯¯¯¯¯\4/0\/4\8\__\4/0\/4\/0\/
        inc_cx      4,4         8,1||4,4        8,1|             |0\4/\0/\4/\0/\4/\0/\4/\
        inc_cx      4,4         8,1||4,4        8,1|             |0/4\/0\/4\/0\/4\/0\/4\/
        inc_cx      4,4         8,1||4,4        8,1|            /4/\0/\4/\0/\4/\0/\4/\0/\
        inc_cx      4,4          8,1\\4,4      8,1/            /0/4\/0\/4\/0\/4\/0\/4\/0\/
        inc_cx           8,1 _   _   _   _   _   _   _   _   _   _  1,1  
        inc_cx           4,1 G   R   I   F   I   N   Ӡ  R   I   A  1,1
        inc_cx           8,1 ¯   ¯   ¯   ¯   ¯   ¯   ¯   ¯   ¯   ¯  1,1  
        inc_cx 
        inc_cx 8,8¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯1,1
        inc_cx 1-
      }
      if ($gettok($gettok(%c'_,1,44),2,32) == Sonserina) {
        inc_cx 9,9¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯1,1
        inc_cx  
        inc_cx           14/09\  \\  \  03/\  14/\  03/\  14/\__ 09/  //  9/3\
        inc_cx          14/  09\  \\  \03/  \15/¯¯¯¯¯¯¯¯ 03¬15  \__9//  9/  3\
        inc_cx          14\  /09\  \\  \  15/    ____  ______/  9/3\  /
        inc_cx           14\/  09\  5><  9\15/    / 03\/ 15\\4____4,03`` 9/  3\/
        inc_cx           03/\  14/09\  \\ 15|    /  14/\  `¯¯¯¯4`  9/3\  14/\
        inc_cx          03/  \14/  09\  \\15|   | 03\14/  \9/   //  /  3\14/  \
        inc_cx          03\  /14\  /09\  \15|   | 03/14\  9/   //  /3\  /14\  /
        inc_cx           03\/  14\/  09\  15\    \  14\9/   //  /  3\/  14\/
        inc_cx           14/\  03/\  14/09\  15\    `.9/   //  /3\  14/\  3/\
        inc_cx          14/  \03/  \14/  09\  15`.   `.  9//  9/  3\14/  \3/  \
        inc_cx          14\  /03\15|\03/14\  /09\  \15\    `9'/  9/3\  /14\  /3\  /
        inc_cx           14\/  15| \ 14\/  09\   15`.    `.9/  3\/  14\/  3\/
        inc_cx           03/\  15|  \03/\  14/09\   5*15`.     `·14/\  3/\  14/\
        inc_cx          03/  \14/15'   \ 03\14/ 09/   /\ 15`.     ',14\3/  \14/  \
        inc_cx          03\  /14\ 15\   \03/14\09/   //\\   15\    |14/3\  /14\  /
        inc_cx           03\/  14\/15\   \09/   //  \\  15,1|    |  3\/  14\/
        inc_cx           14/\  03/\ 15\   \  9//    \\15,01/    /3\  14/\  3/\
        inc_cx          14/  \03/  \14/15\   ¯¯¯¯¯¯¯¯¯¯    /  3\14/  \3/  \
        inc_cx          14\  /03\  /14\09/15\__           _.'9\  3/14\  /3\  /
        inc_cx           14\/  03\/ 09/  //15¯¯¯09,01/15¯14\14/15¯09\15¯¯9\\  09\3/  14\/  3\/
        inc_cx            9,1 _   _   _   _   _   _   _   _   _  1,1  
        inc_cx            15,1 S   O   N   S   E   R   I   N   A  1,1
        inc_cx            9,1 ¯   ¯   ¯   ¯   ¯   ¯   ¯   ¯   ¯  1,1  
        inc_cx 
        inc_cx 9,9¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯1,1
        inc_cx 1-
      }
      if ($gettok($gettok(%c'_,1,44),2,32) == Corvinal) {
        inc_cx 12,12¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯1,1
        inc_cx  
        inc_cx                              14|\               12  | |
        inc_cx                             14/  |            12| | | |
        inc_cx                            14/  //\       12| | | | | | 
        inc_cx                           14/  /  /\  12| | | | | | |  
        inc_cx                          14/  /  / /\ 12| | | | |     
        inc_cx                         14/  /  / / /\12| | |          
        inc_cx                         14| |  / / / /12|           
        inc_cx                       12| 14|  \/ / / /\       
        inc_cx                   12| | | 14|   \/ / / /\           12| | 
        inc_cx               12| | | | | |14\   |/ / / /\    12  | | | |
        inc_cx           12| | | | | | |   14|  | / / / /12  | | | | | |     
        inc_cx       12| | | | | | |      14/   |/ / / /\12| | | | | |      
        inc_cx       12| | | | |  14______ 14|   // / / / /\12 | | |         
        inc_cx       12| | |     14/      \|  |/ / / / / / 12|         
        inc_cx       12|        14| /       \  \/ / / / /           
        inc_cx               14/'\__       \  \/ / / /           
        inc_cx              14/  / /_      |  |/ / /           
        inc_cx           12| 14|  /_/ 12|14\      \  | / /
        inc_cx       12| | | |14\/12| |   14\      ¯¯ \ /
        inc_cx       12| | | | |       14|         ¯¯¯¯\ 
        inc_cx       12| | |           14\              ¯\________
        inc_cx       12|                14\                          
        inc_cx  
        inc_cx               12,1 _   _   _   _   _   _   _   _  1,1  
        inc_cx               15,1 C   O   R   V   I   N   A   L  1,1
        inc_cx               12,1 ¯   ¯   ¯   ¯   ¯   ¯   ¯   ¯  1,1  
        inc_cx 12,12¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯1,1
        inc_cx 1-
      }
      if ($gettok($gettok(%c'_,1,44),2,32) == Lufa-Lufa) {
        inc_cx 08,8¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯1,1
        inc_cx  
        $hp_bandeira(lufa)
        inc_cx  
        inc_cx            08,1 _   _   _   _   _   _   _   _   _  1,1  
        inc_cx            14,1 L   U   F   A   -   L   U   F   A  1,1
        inc_cx            08,1 ¯   ¯   ¯   ¯   ¯   ¯   ¯   ¯   ¯  1,1  
        inc_cx 08,8¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯1,1
        inc_cx 1-
      }
      if ($gettok($gettok(%c'_,1,44),1,32) > 0) { inc_cx Seja Bem Vindo a Hogwarts! O Ano Letivo de $date(yyyy) está correndo, e %cor1 $+ $gettok($gettok(%c'_,1,44),2,32) 0está liderando a Taça das casas com %cor1 $+ $gettok($gettok(%c'_,1,44),1,32) $+ 14pontos0. }
      else { inc_cx Seja Bem Vindo a Hogwarts! O Ano Letivo de $date(yyyy) está pronto para começar! Ajude a sua casa a ganhar a Taça das Casas! Contamos com você. }
      inc_cx 1-
      inc_cx %ncor $+ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
      inc_cx A Escola de Magia e Bruxaria de Hogwarts abre as portas para você. 
      inc_cx Veja as informações de cada uma das quatro casas de nossa escola, e veja a grade de aulas.
      inc_cx 1-
      inc_m %ncor $+ !15Aulas
      inc_m %ncor $+ !15Casas
      inc_cx 1-
      inc_cx %ncor $+ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
      inc_cx Qualquer dúvida ou problema, fale com um %ncor $+ @15Operador0 do canal.
      cx_2
      halt
    }
    if ($strip($1) == !Casas) {
      cx_1
      inc_m Hogwarts - Casas
      inc_m %ncor $+ ¯¯¯¯¯¯¯¯ ¯ ¯¯¯¯¯
      inc_cx             15,7                                  15,1     
      inc_cx             15,7 15,4                15,3                15,7 1,1
      inc_cx             15,7 15,4                15,3                15,7 1,1
      inc_cx             15,7 15,4          15,7     15,4 15,3 15,7     15,3          15,7 1,1
      inc_cx             15,7 15,4          15,7 1,1- -15,7 15,4 15,3 15,7 1,1- -15,7 15,3          15,7 1,1
      inc_cx             15,7 15,4           15,7 1,1|15,7 15,4  15,3  15,7 1,1|15,7 15,3           15,7 1,1
      inc_cx             15,7 15,4           15,7 1,1|15,7 15,4  15,3  15,7 1,1|15,7 15,3           15,7 1,1
      inc_cx             15,7 15,4           15,7 1,1|15,7 15,4  15,3  15,7 1,1|15,7 15,3           15,7 1,1
      inc_cx             15,7 15,4           15,7 1,1|15,7      1,1|15,7 15,3           15,7 1,1
      inc_cx             15,7 15,7            1,1|------|15,7            15,7 1,1
      inc_cx             15,7 15,8           15,7 1,1|15,7      1,1|15,7 15,12           15,7 1,1
      inc_cx             15,7 15,8           15,7 1,1|15,7 15,8  15,12  15,7 1,1|15,7 15,12           15,7 1,1
      inc_cx             15,7 15,8           15,7 1,1|15,7 15,8  15,12  15,7 1,1|15,7 15,12           15,7 1,1
      inc_cx             15,7 15,8           15,7 1,1|15,7 15,8  15,12  15,7 1,1|15,7 15,12           15,7 1,1
      inc_cx             15,7 15,8          15,7 1,1- -15,7 15,8 15,12 15,7 1,1- -15,7 15,12          15,7 1,1
      inc_cx             15,7 15,8          15,7     15,8 15,12 15,7     15,12          15,7 1,1
      inc_cx             15,7 15,8                15,12                15,7 1,1
      inc_cx             15,7 15,8                15,12                15,7 1,1
      inc_cx             15,7                                  15,1     
      inc_cx                                          
      inc_cx Deseja ver as informações das casas da nossa Escola de Magia e Bruxaria de Hogwarts?
      inc_cx Basta escolher o comando relacionado à casa desejada15:
      inc_cx 1-
      inc_m %ncor $+ !15Grifinória
      inc_m %ncor $+ !15Sonserina
      inc_m %ncor $+ !15Lufa-Lufa
      inc_m %ncor $+ !15Corvinal 
      inc_cx 1-
      inc_cx %ncor $+ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
      inc_cx Qualquer dúvida ou problema, fale com um %ncor $+ @15Operador0 do canal.
      cx_2
      halt
    }
    if ($strip($1) == !Aulas) { 
      cx_1
      inc_m Hogwarts - Aulas
      inc_m %ncor $+ ¯¯¯¯¯¯¯¯ ¯ ¯¯¯¯¯
      inc_cx As Matérias estão divididas em 3 Grupos, Matérias Obrigatórias 1 e 2, e Matérias Opcionais. 
      inc_cx 1-
      inc_cx %ncor $+ !15Obrigatórias %ncor $+ 1
      inc_cx %ncor $+ !15Obrigatórias %ncor $+ 2
      inc_cx %ncor $+ !15Matérias Opcionais
      inc_cx 1-
      inc_cx %ncor $+ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
      inc_cx Qualquer dúvida ou problema, fale com um %ncor $+ @15Operador0 do canal.
      cx_2
      halt
    }
    if ($strip($1) == !Matérias) && ($strip($2) == Opcionais) {
      cx_1
      inc_m Matérias Opcionais
      inc_m %ncor $+ ¯¯¯¯¯¯¯¯ ¯¯¯¯¯¯¯¯¯
      var %x = 10
      while (%x <= $ini(aulas.ini,0)) {
        var %aula = $ini(aulas.ini,%x)
        var %mat = $readini(aulas.ini,%aula,mat)
        var %prof = $readini(aulas.ini,%aula,Professor)
        var %dat = $readini(aulas.ini,%aula,dat)
        inc_m  $+ %mat $+ 
        inc_cx Professor15: %ncor $+ %prof
        inc_cx Horário15: %ncor $+ %dat
        inc_cx 1-
        inc %x
      }
      cx_2
      halt
    }
    if ($strip($1) == !Materias) && ($strip($2) == Opcionais) {
      cx_1
      inc_m Matérias Opcionais
      inc_m %ncor $+ ¯¯¯¯¯¯¯¯ ¯¯¯¯¯¯¯¯¯
      var %x = 10
      while (%x <= $ini(aulas.ini,0)) {
        var %aula = $ini(aulas.ini,%x)
        var %mat = $readini(aulas.ini,%aula,mat)
        var %prof = $readini(aulas.ini,%aula,Professor)
        var %dat = $readini(aulas.ini,%aula,dat)
        inc_m  $+ %mat $+ 
        inc_cx Professor15: %ncor $+ %prof
        inc_cx Horário15: %ncor $+ %dat
        inc_cx 1-
        inc %x
      }
      cx_2
      halt
    }
    if ($strip($1) == !Aprender) {
      if (!$2) { cx_1 | inc_m Sintaxe Incorreta. | inc_m %ncor $+ !15Feitiço <nome do feitiço> | cx_2 | halt }
      var %feit = $strip($2)
      if ($3 != $null) { var %feit = $replace($strip($2-),$chr(32),$chr(46)) }
      if ($readini(magias.ini,%feit,nome) == $null) { cx_1 | inc_m Feitiço Não encontrado. | cx_2 | halt }
      if ($readini(magias.ini,%feit,nivel) > $nivel_nick($nick)) { cx_1 | inc_m Você ainda não pode aprender esse feitiço. | cx_2 | halt }
      if (* $strip($2-) * isin $readini(hp.ini,$nick,feiticos)) { cx_1 | inc_m Você já aprendeu esse feitiço. | cx_2 | halt }
      if ($readini(hp.ini,$nick,nfon) == sim) { cx_1 | inc_m Você está no meio do Aprendizado de um feitiço. | cx_2 | halt }
      if ($readini(hp.ini,$nick,nfdata) == $date) { cx_1 | inc_m Você aprendeu um feitiço hoje, descance agora. | cx_2 | halt }
      if ($readini(hp.ini,$nick,temres) != $null) { halt }
      var %nomf = $readini(magias.ini,%feit,nome)
      var %nivf = $readini(magias.ini,%feit,nivel)
      var %dayf = $readini(magias.ini,%feit,dias)
      cx_1
      inc_m Aprender Feitiços
      inc_m %ncor $+ ¯¯¯¯¯¯¯¯ ¯¯¯¯¯¯¯¯
      inc_cx Você está querendo aprender um Feitiço, confirme os dados do mesmo abaixo.
      inc_cx 1-
      inc_cx Feitiço15: %ncor $+ %nomf
      inc_cx Nível15: %ncor $+ %nivf
      inc_cx 1-
      inc_cx Esse Feitiço tem a duração de %ncor $+ %dayf 0dia(s) de treinamento, caso queria aprender o feitiço, digite %ncor $+ !15Confirmar0, caso não digite %ncor $+ !15Desistir0.
      inc_cx Se você não responder em %ncor $+ 30 0segundos o treinamento será cancelado.
      cx_2
      writeini hp.ini $nick temres %feit
      timer $+ feit $+ $nick 1 30 msg =$nick 1,1 15,15 4,1 Você não respondeu o comando, treinamento cancelado. 15,15 1,1 
      timer $+ feit $+ $nick $+ 1 1 30 remini hp.ini $nick temres
      halt
    }
    if ($strip($1) == !Desistir) {
      if ($readini(hp.ini,$nick,temres) == $null) { cx_1 | inc_m 4Hora errada, comando errado. | cx_2 | halt }
      timer $+ feit $+ $nick off
      timer $+ feit $+ $nick $+ 1 off
      cx_1
      inc_m Treinamento Cancelado
      inc_cx 1-
      inc_cx Você desistiu de aprender o feitiço15: %ncor $+ $readini(hp.ini,$nick,temres)
      cx_2
      remini hp.ini $nick temres
    }
    if ($strip($1) == !Confirmar) {
      if ($readini(hp.ini,$nick,temres) == $null) { cx_1 | inc_m 4Hora errada, comando errado. | cx_2 | halt }
      timer $+ feit $+ $nick off
      timer $+ feit $+ $nick $+ 1 off
      var %feit = $readini(hp.ini,$nick,temres)
      remini hp.ini $nick temres
      var %dayf = $readini(magias.ini,%feit,dias)
      var %nomf = $readini(magias.ini,%feit,nome)
      writeini hp.ini $nick nfon sim
      writeini hp.ini $nick nftr %feit
      writeini hp.ini $nick nfdi 0
      cx_1 
      inc_m Aprender Feitiços
      inc_m %ncor $+ ¯¯¯¯¯¯¯¯ ¯¯¯¯¯¯¯¯
      inc_cx Confirmado!
      inc_cx 1-
      inc_cx Você já pode começar a treinar o Feitiço %ncor $+ %nomf
      inc_cx Dias de treino15: %ncor $+ %dayf
      inc_cx Para treinar o feitiço digite %ncor $+ !15Treino de Feitiço
      cx_2
      halt
    }
    if ($strip($1-) == !treino de feitiço) { 
      if ($readini(hp.ini,$nick,nfon) != sim) { cx_1 | inc_m Você não está tendo treino de feitiços. | cx_2 | halt }
      if ($readini(hp.ini,$nick,tempf) == sim) { cx_1 | inc_m Você já está treinando o feitiço. | cx_2 | halt } 
      if ($readini(hp.ini,$nick,datf) == $date) { cx_1 | inc_m Você já realizou o treinamento de feitiços hoje. | cx_2 | halt }
      var %feit = $readini(hp.ini,$nick,nftr)
      var %fei = $readini(magias.ini,%feit,nome)
      var %dt = $readini(hp.ini,$nick,nfdi)
      var %dpt = $readini(magias.ini,%feit,dias)
      writeini hp.ini $nick tempf $date
      cx_1
      inc_m Treino de Feitiço
      inc_m %ncor $+ ¯¯¯¯¯¯ ¯¯ ¯¯¯¯¯¯¯
      inc_cx Treinando o Feitiço %ncor %fei
      inc_cx Duração do Treino15: %ncor $+ 10 Minutos
      inc_m $calc(%dt + 1) $+ º Treino
      inc_cx 1-
      inc_cx Hora Atual: %ncor $+ $time
      inc_cx Hora Final: %ncor $+ $duration($calc((10 * 60) + $duration($time)),3)
      cx_2
      timer 1 600 treino_feiti $nick
      halt 
    }
    if ($strip($1-) == !treino de feitico) { 
      if ($readini(hp.ini,$nick,nfon) != sim) { cx_1 | inc_m Você não está tendo treino de feitiços. | cx_2 | halt }
      if ($readini(hp.ini,$nick,tempf) == sim) { cx_1 | inc_m Você já está treinando o feitiço. | cx_2 | halt } 
      if ($readini(hp.ini,$nick,datf) == $date) { cx_1 | inc_m Você já realizou o treinamento de feitiços hoje. | cx_2 | halt }
      var %feit = $readini(hp.ini,$nick,nftr)
      var %fei = $readini(magias.ini,%feit,nome)
      var %dt = $readini(hp.ini,$nick,nfdi)
      var %dpt = $readini(magias.ini,%feit,dias)
      writeini hp.ini $nick tempf $date
      cx_1
      inc_m Treino de Feitiço
      inc_m %ncor $+ ¯¯¯¯¯¯ ¯¯ ¯¯¯¯¯¯¯
      inc_cx Treinando o Feitiço %ncor %fei
      inc_cx Duração do Treino15: %ncor $+ 10 Minutos
      inc_m $calc(%dt + 1) $+ º Treino
      inc_cx 1-
      inc_cx Hora Atual: %ncor $+ $time
      inc_cx Hora Final: %ncor $+ $duration($calc((10 * 60) + $duration($time)),3)
      cx_2
      timer 1 600 treino_feiti $nick
      halt 
    }
    if ($strip($1) == !Níveis) { feitic_hp | halt }
    if ($strip($1) == !Nível) { 
      if ($strip($2) == $null) { cx_1 | inc_cx Coloque um nível no comando | cx_2 | halt }
      if ($strip($2) !isnum) { cx_1 | inc_cx Coloque um nível numérico no comando | cx_2 | halt }
      if ($strip($2) > 40) { halt }
      $listar_niv($strip($2)) 
      halt 
    }
    if ($strip($1) == !Feitiço) {
      if (!$2) { 
        cx_1 
        inc_m Hogwarts - Feitiços
        inc_m %ncor $+ ¯¯¯¯¯¯¯¯ ¯ ¯¯¯¯¯¯¯¯
        inc_cx     A Partir de agora, para aprender a fazer qualquer 
        inc_cx      feitiço, você deverá iniciar um treinamento que 
        inc_cx       dependendo do nível poderá durar até %ncor $+ 10 0dias.
        inc_cx       Os comandos adicionados nessa categoria são:
        inc_cx 1-
        inc_m %ncor $+ !15Feitiço <nome do feitiço>
        inc_m %ncor $+ !15Feitiços <nick>
        inc_m %ncor $+ !15Aprender <nome do feitiço>
        inc_m %ncor $+ !15Treino de Feitiço
        inc_m %ncor $+ !15Níveis
        inc_m %ncor $+ !15Nível <num>
        inc_cx 1-
        inc_cx %ncor $+ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
        inc_cx Qualquer dúvida, fale com um de nossos %ncor $+ @ 0Operadores.
        cx_2 
        halt 
      }
      var %feit = $replace($strip($2-),$chr(32),$chr(46))
      if ($readini(magias.ini,%feit,nome) == $null) { cx_1 | inc_m Feitiço Não encontrado | cx_2 | halt }
      cx_1
      inc_m Hogwarts - Feitiços
      inc_m %ncor $+ ¯¯¯¯¯¯¯¯ ¯ ¯¯¯¯¯¯¯¯
      inc_cx           Nome 15,15 0,1 %ncor $+ $readini(magias.ini,%feit,nome)
      inc_cx          Nível 15,15 0,1 %ncor $+ $readini(magias.ini,%feit,nivel)
      inc_cx     Mencionado 15,15 0,1 %ncor $+ $readini(magias.ini,%feit,view)
      inc_cx 1-
      inc_m Descrição
      inc_m2 $readini(magias.ini,%feit,desc)
      cx_2
      halt
    }
    if ($strip($1) == !Feitico) {
      if (!$2) { 
        cx_1 
        inc_m Hogwarts - Feitiços
        inc_m %ncor $+ ¯¯¯¯¯¯¯¯ ¯ ¯¯¯¯¯¯¯¯
        inc_cx     A Partir de agora, para aprender a fazer qualquer 
        inc_cx      feitiço, você deverá iniciar um treinamento que 
        inc_cx       dependendo do nível poderá durar até %ncor $+ 10 0dias.
        inc_cx       Os comandos adicionados nessa categoria são:
        inc_cx 1-
        inc_m %ncor $+ !15Feitiço <nome do feitiço>
        inc_m %ncor $+ !15Feitiços <nick>
        inc_m %ncor $+ !15Aprender <nome do feitiço>
        inc_m %ncor $+ !15Treino de Feitiço
        inc_m %ncor $+ !15Níveis
        inc_m %ncor $+ !15Nível <num>
        inc_cx 1-
        inc_cx %ncor $+ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
        inc_cx Qualquer dúvida, fale com um de nossos %ncor $+ @ 0Operadores.
        cx_2 
        halt 
      }
      var %feit = $replace($strip($2-),$chr(32),$chr(46))
      if ($readini(magias.ini,%feit,nome) == $null) { cx_1 | inc_m Feitiço Não encontrado | cx_2 | halt }
      cx_1
      inc_m Hogwarts - Feitiços
      inc_m %ncor $+ ¯¯¯¯¯¯¯¯ ¯ ¯¯¯¯¯¯¯¯
      inc_cx           Nome 15,15 0,1 %ncor $+ $readini(magias.ini,%feit,nome)
      inc_cx          Nível 15,15 0,1 %ncor $+ $readini(magias.ini,%feit,nivel)
      inc_cx     Mencionado 15,15 0,1 %ncor $+ $readini(magias.ini,%feit,view)
      inc_cx 1-
      inc_m Descrição
      inc_m2 $readini(magias.ini,%feit,desc)
      cx_2
      halt
    }
    if ($strip($1) == @Feitiços) { 
      if ($2 == $null) { var %nic_f = $nick }
      else { var %nic_f = $strip($2) }
      if ($readini(hp.ini,%nic_f,nick) == $null) { cx_1 | inc_m %nic_f não está matriculado | cx_2 | halt }
      $mostra_feiticos(%nic_f)
      halt
    }
    if ($strip($1) == !Feiticos) { 
      if ($2 == $null) { var %nic_f = $nick }
      else { var %nic_f = $strip($2) }
      if ($readini(hp.ini,%nic_f,nick) == $null) { cx_1 | inc_m %nic_f não está matriculado | cx_2 | halt }
      $mostra_feiticos(%nic_f)
      halt
    }
    if ($1 == !tess) { 
      cx_1
      inc_cx 12,12¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯1,1
      inc_cx  
      inc_cx                              14|\               12  | |
      inc_cx                             14/  |            12| | | |
      inc_cx                            14/  //\       12| | | | | | 
      inc_cx                           14/  /  /\  12| | | | | | |  
      inc_cx                          14/  /  / /\ 12| | | | |     
      inc_cx                         14/  /  / / /\12| | |          
      inc_cx                         14| |  / / / /12|           
      inc_cx                       12| 14|  \/ / / /\       
      inc_cx                   12| | | 14|   \/ / / /\           12| | 
      inc_cx               12| | | | | |14\   |/ / / /\    12  | | | |
      inc_cx           12| | | | | | |   14|  | / / / /12  | | | | | |     
      inc_cx       12| | | | | | |      14/   |/ / / /\12| | | | | |      
      inc_cx       12| | | | |  14______ 14|   // / / / /\12 | | |         
      inc_cx       12| | |     14/      \|  |/ / / / / / 12|         
      inc_cx       12|        14| /       \  \/ / / / /           
      inc_cx               14/'\__       \  \/ / / /           
      inc_cx              14/  / /_      |  |/ / /           
      inc_cx           12| 14|  /_/ 12|14\      \  | / /
      inc_cx       12| | | |14\/12| |   14\      ¯¯ \ /
      inc_cx       12| | | | |       14|         ¯¯¯¯\ 
      inc_cx       12| | |           14\              ¯\________
      inc_cx       12|                14\                          
      inc_cx  
      inc_cx               12,1 _   _   _   _   _   _   _   _  1,1  
      inc_cx               15,1 C   O   R   V   I   N   A   L  1,1
      inc_cx               12,1 ¯   ¯   ¯   ¯   ¯   ¯   ¯   ¯  1,1  
      inc_cx 12,12¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯1,1
      inc_cx 1-
      cx_2
      halt
    }
    if ($strip($1) == !Obrigatórias) {
      if ($strip($2) == 1) {
        cx_1
        inc_m Matérias Obrigatórias 1
        inc_m %ncor $+ ¯¯¯¯¯¯¯¯ ¯¯¯¯¯¯¯¯¯¯¯¯ ¯
        var %x = 1
        while (%x <= 5) {
          var %aula = $ini(aulas.ini,%x)
          var %mat = $readini(aulas.ini,%aula,mat)
          var %prof = $readini(aulas.ini,%aula,Professor)
          var %dat = $readini(aulas.ini,%aula,dat)
          inc_m  $+ %mat $+ 
          inc_cx Professor15: %ncor $+ %prof
          inc_cx Horário15: %ncor $+ %dat
          inc_cx 1-
          inc %x
        }
        cx_2
        halt
      }
      if ($strip($2) == 2) {
        cx_1
        inc_m Matérias Obrigatórias 2
        inc_m %ncor $+ ¯¯¯¯¯¯¯¯ ¯¯¯¯¯¯¯¯¯¯¯¯ ¯
        var %x = 6
        while (%x <= 9) {
          var %aula = $ini(aulas.ini,%x)
          var %mat = $readini(aulas.ini,%aula,mat)
          var %prof = $readini(aulas.ini,%aula,Professor)
          var %dat = $readini(aulas.ini,%aula,dat)
          inc_m  $+ %mat $+ 
          inc_cx Professor15: %ncor $+ %prof
          inc_cx Horário15: %ncor $+ %dat
          inc_cx 1-
          inc %x
        }
        cx_2
        halt
      }
      halt
    }
    if ($strip($1) == !Start.Radio) { goradio | halt }
    if ($strip($1) == !Lufa-Lufa) {
      $ta_casa(Lufa-Lufa)
      $hist_lut(Lufa-Lufa)
      $casa_top(Lufa-Lufa)
      var %cas = lufa-lufa
      if (%cas == corvinal) { set %ncor2 11,11 | set %ncor 11 }
      if (%cas == grifinória) { set %ncor2 04,04 | set %ncor 04 }
      if (%cas == lufa-lufa) { set %ncor2 08,08 | set %ncor 08 }
      if (%cas == sonserina) { set %ncor2 09,09 | set %ncor 09 }
      if (%cas == $null) { set %ncor2 15,15 | set %ncor 15 }
      cx_1
      inc_m 08_ _ _ _   _ _ _ _
      inc_m 14L U F A - L U F A
      inc_m 08¯ ¯ ¯ ¯   ¯ ¯ ¯ ¯
      $hp_bandeira(lufa)
      inc_m 1-
      inc_m 8Helga Hufflepuff
      inc_cx %ncor $+ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
      inc_cx Diretor15:08 $readini(casas.ini,lufa-lufa,Diretor) $+ $str($chr(160),$calc(27 - $len($readini(casas.ini,sonserina,Diretor)))) 15Aluno Exemplo
      inc_cx Taça das casas15:08 %ta.top $+ º 14Lugar $+ $str($chr(160),$calc(20 - $calc($len(%ta.top) + 7)))) 08 $+ %alu.nom
      inc_cx Pontuação15:08 %ta.pont 14Pontos $+ $str($chr(160),$calc(25 - $calc($len(%ta.pont) + 7)))) 14 $+ %alu.pts ponto(s)
      inc_cx Nº de Alunos15:08 %n.alunos
      inc_cx 1-
      inc_cx %ncor $+ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
      inc_m 14Estatísticas
      inc_m 08¯¯¯¯¯¯¯¯¯¯¯¯
      inc_cx 1-
      inc_cx   Vitórias15:09 %his.vit $+ $str($chr(160),$calc(15 - $len(%his.vit))) 15+09VIT15:08 %top.vit 
      inc_cx    Empates15:08 %his.emp $+ $str($chr(160),$calc(15 - $len(%his.emp))) 15+08EMP15:08 %top.emp 
      inc_cx   Derrotas15:04 %his.der $+ $str($chr(160),$calc(15 - $len(%his.der))) 15+04DER15:08 %top.der 
      inc_cx  Narrações15:11 %his.nar $+ $str($chr(160),$calc(15 - $len(%his.nar))) 15+11NAR15:08 %top.nar 
      inc_cx 1-
      inc_cx %ncor $+ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
      inc_m 14TOP 3 ALUNOS
      inc_m 08¯¯¯ ¯ ¯¯¯¯¯¯
      inc_cx 14Pos Nick $+ $str($chr(160),16) Magia     09V15/08E15/04D15/07N
      inc_cx  141º08 %top.cas1 $+ $str($chr(160),$calc(20 - $len(%top.cas1))) $replace($bytes($readini(hp.ini,%top.cas1,mag),db),$chr(44),$chr(46)) $+ $str($chr(160),$calc(9 - $len($replace($bytes($readini(hp.ini,%top.cas1,mag),db),$chr(44),$chr(46))))) 09 $+ $readini(hp.ini,%top.cas1,vit) $+ 15/08 $+ $readini(hp.ini,%top.cas1,emp) $+ 15/04 $+ $readini(hp.ini,%top.cas1,der) $+ 15/07 $+ $readini(hp.ini,%top.cas1,nar)
      inc_cx  142º08 %top.cas2 $+ $str($chr(160),$calc(20 - $len(%top.cas2))) $replace($bytes($readini(hp.ini,%top.cas2,mag),db),$chr(44),$chr(46)) $+ $str($chr(160),$calc(9 - $len($replace($bytes($readini(hp.ini,%top.cas2,mag),db),$chr(44),$chr(46))))) 09 $+ $readini(hp.ini,%top.cas2,vit) $+ 15/08 $+ $readini(hp.ini,%top.cas2,emp) $+ 15/04 $+ $readini(hp.ini,%top.cas2,der) $+ 15/07 $+ $readini(hp.ini,%top.cas2,nar)
      inc_cx  143º08 %top.cas3 $+ $str($chr(160),$calc(20 - $len(%top.cas3))) $replace($bytes($readini(hp.ini,%top.cas3,mag),db),$chr(44),$chr(46)) $+ $str($chr(160),$calc(9 - $len($replace($bytes($readini(hp.ini,%top.cas3,mag),db),$chr(44),$chr(46))))) 09 $+ $readini(hp.ini,%top.cas3,vit) $+ 15/08 $+ $readini(hp.ini,%top.cas3,emp) $+ 15/04 $+ $readini(hp.ini,%top.cas3,der) $+ 15/07 $+ $readini(hp.ini,%top.cas3,nar)
      inc_cx 
      cx_2
      unset %n.alunos
      unset %alu.nom
      unset %alu.pts
      unset %top.cas1
      unset %top.cas2
      unset %top.cas3
      unset %top.vit
      unset %top.emp
      unset %top.der
      unset %top.nar
      unset %his.nar
      unset %his.vit
      unset %his.der
      unset %his.emp
      unset %ta.top
      unset %ta.pont
      halt
    }
    if ($strip($1) == !Sonserina) {
      $ta_casa(Sonserina)
      $hist_lut(Sonserina)
      $casa_top(Sonserina)
      var %cas = sonserina
      if (%cas == corvinal) { set %ncor2 11,11 | set %ncor 11 }
      if (%cas == grifinória) { set %ncor2 04,04 | set %ncor 04 }
      if (%cas == lufa-lufa) { set %ncor2 08,08 | set %ncor 08 }
      if (%cas == sonserina) { set %ncor2 09,09 | set %ncor 09 }
      if (%cas == $null) { set %ncor2 15,15 | set %ncor 15 }
      cx_1
      inc_m 3_ _ _ _ _ _ _ _ _
      inc_m 15S O N S E R I N A
      inc_m 3¯ ¯ ¯ ¯ ¯ ¯ ¯ ¯ ¯
      $hp_bandeira(sons)
      inc_m 1-
      inc_m 3Salazar Slytherin
      inc_cx %ncor $+ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
      inc_cx Diretor15:03 $readini(casas.ini,sonserina,Diretor) $+ $str($chr(160),$calc(27 - $len($readini(casas.ini,sonserina,Diretor)))) 15Aluno Exemplo
      inc_cx Taça das casas15:03 %ta.top $+ º 14Lugar $+ $str($chr(160),$calc(20 - $calc($len(%ta.top) + 7)))) 03 $+ %alu.nom
      inc_cx Pontuação15:03 %ta.pont 14Pontos $+ $str($chr(160),$calc(25 - $calc($len(%ta.pont) + 7)))) 15 $+ %alu.pts ponto(s)
      inc_cx Nº de Alunos15:03 %n.alunos
      inc_cx 1-
      inc_cx %ncor $+ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
      inc_m 15Estatísticas
      inc_m 03¯¯¯¯¯¯¯¯¯¯¯¯
      inc_cx 1-
      inc_cx   Vitórias15:09 %his.vit $+ $str($chr(160),$calc(15 - $len(%his.vit))) 15+09VIT15:03 %top.vit 
      inc_cx    Empates15:08 %his.emp $+ $str($chr(160),$calc(15 - $len(%his.emp))) 15+08EMP15:03 %top.emp 
      inc_cx   Derrotas15:04 %his.der $+ $str($chr(160),$calc(15 - $len(%his.der))) 15+04DER15:03 %top.der 
      inc_cx  Narrações15:11 %his.nar $+ $str($chr(160),$calc(15 - $len(%his.nar))) 15+11NAR15:03 %top.nar 
      inc_cx 1-
      inc_cx %ncor $+ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
      inc_m 15TOP 3 ALUNOS
      inc_m 3¯¯¯ ¯ ¯¯¯¯¯¯
      inc_cx 14Pos Nick $+ $str($chr(160),16) Magia     09V15/08E15/04D15/07N
      inc_cx  141º15 %top.cas1 $+ $str($chr(160),$calc(20 - $len(%top.cas1))) $replace($bytes($readini(hp.ini,%top.cas1,mag),db),$chr(44),$chr(46)) $+ $str($chr(160),$calc(9 - $len($replace($bytes($readini(hp.ini,%top.cas1,mag),db),$chr(44),$chr(46))))) 09 $+ $readini(hp.ini,%top.cas1,vit) $+ 15/08 $+ $readini(hp.ini,%top.cas1,emp) $+ 15/04 $+ $readini(hp.ini,%top.cas1,der) $+ 15/07 $+ $readini(hp.ini,%top.cas1,nar)
      inc_cx  142º15 %top.cas2 $+ $str($chr(160),$calc(20 - $len(%top.cas2))) $replace($bytes($readini(hp.ini,%top.cas2,mag),db),$chr(44),$chr(46)) $+ $str($chr(160),$calc(9 - $len($replace($bytes($readini(hp.ini,%top.cas2,mag),db),$chr(44),$chr(46))))) 09 $+ $readini(hp.ini,%top.cas2,vit) $+ 15/08 $+ $readini(hp.ini,%top.cas2,emp) $+ 15/04 $+ $readini(hp.ini,%top.cas2,der) $+ 15/07 $+ $readini(hp.ini,%top.cas2,nar)
      inc_cx  143º15 %top.cas3 $+ $str($chr(160),$calc(20 - $len(%top.cas3))) $replace($bytes($readini(hp.ini,%top.cas3,mag),db),$chr(44),$chr(46)) $+ $str($chr(160),$calc(9 - $len($replace($bytes($readini(hp.ini,%top.cas3,mag),db),$chr(44),$chr(46))))) 09 $+ $readini(hp.ini,%top.cas3,vit) $+ 15/08 $+ $readini(hp.ini,%top.cas3,emp) $+ 15/04 $+ $readini(hp.ini,%top.cas3,der) $+ 15/07 $+ $readini(hp.ini,%top.cas3,nar)
      inc_cx 
      cx_2
      unset %n.alunos
      unset %alu.nom
      unset %alu.pts
      unset %top.cas1
      unset %top.cas2
      unset %top.cas3
      unset %top.vit
      unset %top.emp
      unset %top.der
      unset %top.nar
      unset %his.nar
      unset %his.vit
      unset %his.der
      unset %his.emp
      unset %ta.top
      unset %ta.pont
      halt
    }
    if ($strip($1) == !Corvinal) {
      $ta_casa(Corvinal)
      $hist_lut(Corvinal)
      $casa_top(Corvinal)
      var %cas = corvinal
      if (%cas == corvinal) { set %ncor2 11,11 | set %ncor 11 }
      if (%cas == grifinória) { set %ncor2 04,04 | set %ncor 04 }
      if (%cas == lufa-lufa) { set %ncor2 08,08 | set %ncor 08 }
      if (%cas == sonserina) { set %ncor2 09,09 | set %ncor 09 }
      if (%cas == $null) { set %ncor2 15,15 | set %ncor 15 }
      cx_1
      inc_m 12_ _ _ _ _ _ _ _
      inc_m 15C O R V I N A L
      inc_m 12¯ ¯ ¯ ¯ ¯ ¯ ¯ ¯
      $hp_bandeira(corv)
      inc_m 1-
      inc_m 12Rowena Ravenclaw
      inc_cx %ncor $+ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
      inc_cx Diretor15:15 $readini(casas.ini,Corvinal,Diretor) $+ $str($chr(160),$calc(27 - $len($readini(casas.ini,Corvinal,Diretor)))) 15Aluno Exemplo
      inc_cx Taça das casas15:15 %ta.top $+ º 14Lugar $+ $str($chr(160),$calc(20 - $calc($len(%ta.top) + 7)))) 12 $+ %alu.nom
      inc_cx Pontuação15:15 %ta.pont 14Pontos $+ $str($chr(160),$calc(25 - $calc($len(%ta.pont) + 7)))) 15 $+ %alu.pts ponto(s)
      inc_cx Nº de Alunos15:15 %n.alunos
      inc_cx 1-
      inc_cx %ncor $+ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
      inc_m 15Estatísticas
      inc_m 12¯¯¯¯¯¯¯¯¯¯¯¯
      inc_cx 1-
      inc_cx   Vitórias15:09 %his.vit $+ $str($chr(160),$calc(15 - $len(%his.vit))) 15+09VIT15:12 %top.vit 
      inc_cx    Empates15:08 %his.emp $+ $str($chr(160),$calc(15 - $len(%his.emp))) 15+08EMP15:12 %top.emp 
      inc_cx   Derrotas15:04 %his.der $+ $str($chr(160),$calc(15 - $len(%his.der))) 15+04DER15:12 %top.der 
      inc_cx  Narrações15:11 %his.nar $+ $str($chr(160),$calc(15 - $len(%his.nar))) 15+11NAR15:12 %top.nar 
      inc_cx 1-
      inc_cx %ncor $+ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
      inc_m 15TOP 3 ALUNOS
      inc_m 12¯¯¯ ¯ ¯¯¯¯¯¯
      inc_cx 14Pos Nick $+ $str($chr(160),16) Magia     09V15/08E15/04D15/07N
      inc_cx  141º15 %top.cas1 $+ $str($chr(160),$calc(20 - $len(%top.cas1))) $replace($bytes($readini(hp.ini,%top.cas1,mag),db),$chr(44),$chr(46)) $+ $str($chr(160),$calc(9 - $len($replace($bytes($readini(hp.ini,%top.cas1,mag),db),$chr(44),$chr(46))))) 09 $+ $readini(hp.ini,%top.cas1,vit) $+ 15/08 $+ $readini(hp.ini,%top.cas1,emp) $+ 15/04 $+ $readini(hp.ini,%top.cas1,der) $+ 15/07 $+ $readini(hp.ini,%top.cas1,nar)
      inc_cx  142º15 %top.cas2 $+ $str($chr(160),$calc(20 - $len(%top.cas2))) $replace($bytes($readini(hp.ini,%top.cas2,mag),db),$chr(44),$chr(46)) $+ $str($chr(160),$calc(9 - $len($replace($bytes($readini(hp.ini,%top.cas2,mag),db),$chr(44),$chr(46))))) 09 $+ $readini(hp.ini,%top.cas2,vit) $+ 15/08 $+ $readini(hp.ini,%top.cas2,emp) $+ 15/04 $+ $readini(hp.ini,%top.cas2,der) $+ 15/07 $+ $readini(hp.ini,%top.cas2,nar)
      inc_cx  143º15 %top.cas3 $+ $str($chr(160),$calc(20 - $len(%top.cas3))) $replace($bytes($readini(hp.ini,%top.cas3,mag),db),$chr(44),$chr(46)) $+ $str($chr(160),$calc(9 - $len($replace($bytes($readini(hp.ini,%top.cas3,mag),db),$chr(44),$chr(46))))) 09 $+ $readini(hp.ini,%top.cas3,vit) $+ 15/08 $+ $readini(hp.ini,%top.cas3,emp) $+ 15/04 $+ $readini(hp.ini,%top.cas3,der) $+ 15/07 $+ $readini(hp.ini,%top.cas3,nar)
      inc_cx 
      cx_2
      unset %n.alunos
      unset %alu.nom
      unset %alu.pts
      unset %top.cas1
      unset %top.cas2
      unset %top.cas3
      unset %top.vit
      unset %top.emp
      unset %top.der
      unset %top.nar
      unset %his.nar
      unset %his.vit
      unset %his.der
      unset %his.emp
      unset %ta.top
      unset %ta.pont
      halt
    }
    if ($strip($1) == !Grifinória) {
      $ta_casa(grifinória)
      $hist_lut(grifinória)
      $casa_top(grifinória)
      var %cas = grifinória
      if (%cas == corvinal) { set %ncor2 11,11 | set %ncor 11 }
      if (%cas == grifinória) { set %ncor2 04,04 | set %ncor 04 }
      if (%cas == lufa-lufa) { set %ncor2 08,08 | set %ncor 08 }
      if (%cas == sonserina) { set %ncor2 09,09 | set %ncor 09 }
      if (%cas == $null) { set %ncor2 15,15 | set %ncor 15 }
      cx_1
      inc_m 4_ _ _ _ _ _ _ _ _ _
      inc_m 8G R I F I N Ó R I A
      inc_m 4¯ ¯ ¯ ¯ ¯ ¯ ¯ ¯ ¯ ¯
      $hp_bandeira(grif)
      inc_m 1-
      inc_m 8Godryc Griffyndor
      inc_cx %ncor $+ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
      inc_cx Diretor15:04 $readini(casas.ini,grifinória,Diretor) $+ $str($chr(160),$calc(27 - $len($readini(casas.ini,grifinória,Diretor)))) 15Aluno Exemplo
      inc_cx Taça das casas15:04 %ta.top $+ º 14Lugar $+ $str($chr(160),$calc(20 - $calc($len(%ta.top) + 7)))) 08 $+ %alu.nom
      inc_cx Pontuação15:04 %ta.pont 14Pontos $+ $str($chr(160),$calc(25 - $calc($len(%ta.pont) + 7)))) 04 $+ %alu.pts ponto(s)
      inc_cx Nº de Alunos15:04 %n.alunos
      inc_cx 1-
      inc_cx %ncor $+ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
      inc_m Estatísticas
      inc_cx 1-
      inc_cx   Vitórias15:09 %his.vit $+ $str($chr(160),$calc(15 - $len(%his.vit))) 15+09VIT15:04 %top.vit 
      inc_cx    Empates15:08 %his.emp $+ $str($chr(160),$calc(15 - $len(%his.emp))) 15+08EMP15:04 %top.emp 
      inc_cx   Derrotas15:04 %his.der $+ $str($chr(160),$calc(15 - $len(%his.der))) 15+04DER15:04 %top.der 
      inc_cx  Narrações15:11 %his.nar $+ $str($chr(160),$calc(15 - $len(%his.nar))) 15+11NAR15:04 %top.nar 
      inc_cx 1-
      inc_cx %ncor $+ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
      inc_m 8TOP 3 ALUNOS
      inc_m 4¯¯¯ ¯ ¯¯¯¯¯¯
      inc_cx 14Pos Nick $+ $str($chr(160),16) Magia     09V15/08E15/04D15/07N
      inc_cx  141º08 %top.cas1 $+ $str($chr(160),$calc(20 - $len(%top.cas1))) $replace($bytes($readini(hp.ini,%top.cas1,mag),db),$chr(44),$chr(46)) $+ $str($chr(160),$calc(9 - $len($replace($bytes($readini(hp.ini,%top.cas1,mag),db),$chr(44),$chr(46))))) 09 $+ $readini(hp.ini,%top.cas1,vit) $+ 15/08 $+ $readini(hp.ini,%top.cas1,emp) $+ 15/04 $+ $readini(hp.ini,%top.cas1,der) $+ 15/07 $+ $readini(hp.ini,%top.cas1,nar)
      inc_cx  142º08 %top.cas2 $+ $str($chr(160),$calc(20 - $len(%top.cas2))) $replace($bytes($readini(hp.ini,%top.cas2,mag),db),$chr(44),$chr(46)) $+ $str($chr(160),$calc(9 - $len($replace($bytes($readini(hp.ini,%top.cas2,mag),db),$chr(44),$chr(46))))) 09 $+ $readini(hp.ini,%top.cas2,vit) $+ 15/08 $+ $readini(hp.ini,%top.cas2,emp) $+ 15/04 $+ $readini(hp.ini,%top.cas2,der) $+ 15/07 $+ $readini(hp.ini,%top.cas2,nar)
      inc_cx  143º08 %top.cas3 $+ $str($chr(160),$calc(20 - $len(%top.cas3))) $replace($bytes($readini(hp.ini,%top.cas3,mag),db),$chr(44),$chr(46)) $+ $str($chr(160),$calc(9 - $len($replace($bytes($readini(hp.ini,%top.cas3,mag),db),$chr(44),$chr(46))))) 09 $+ $readini(hp.ini,%top.cas3,vit) $+ 15/08 $+ $readini(hp.ini,%top.cas3,emp) $+ 15/04 $+ $readini(hp.ini,%top.cas3,der) $+ 15/07 $+ $readini(hp.ini,%top.cas3,nar)
      inc_cx 
      cx_2
      unset %n.alunos
      unset %alu.nom
      unset %alu.pts
      unset %top.cas1
      unset %top.cas2
      unset %top.cas3
      unset %top.vit
      unset %top.emp
      unset %top.der
      unset %top.nar
      unset %his.nar
      unset %his.vit
      unset %his.der
      unset %his.emp
      unset %ta.top
      unset %ta.pont
      halt
    }
    if ($strip($1) == !Del) && ($readini(accesshp.ini,$nick,nv) >= 5) {
      if ($readini(hp.ini,$strip($2),nick) == $null) { cx_1 | inc_m O Aluno não está matriculado | cx_2 | halt }
      remini hp.ini $strip($2)
      cx_1
      inc_m Del
      inc_cx 1-
      inc_cx O Aluno %ncor $+ $strip($2) 0foi deletado com sucesso
      cx_2
      halt
    }
    if ($strip($1) == !Aula.hora) && ($readini(accesshp.ini,$nick,nv) >= 3) {
      if ($readini(aulas.ini,$strip($2),mat) == $null) { cx_1 | inc_m Matéria inexistente. | cx_2 | halt }
      if ($3 == $null) { cx_1 | inc_m Coloque o novo Horário. | cx_2 | halt }
      writeini aulas.ini $strip($2) dat $strip($3-)
      cx_1 | inc_m Horário Alterado da aula de  $+ $strip($2) $+ 15: %ncor $+ $strip($3-) | cx_2
      halt
    }
    if ($strip($1) == !Set) && ($readini(accesshp.ini,$nick,nv) >= 4) {
      if ($strip($2) == Professor) {
        if ($readini(aulas.ini,$strip($3),mat) == $null) { cx_1 | inc_m Matéria não existe na nossa Escola. | cx_2 | halt }
        if ($strip($4) != $null) {
          writeini hp.ini $strip($4) car Professor de $strip($3)
          writeini aulas.ini $strip($3) Professor $strip($4)
          cx_1 | inc_m %ncor $+ $strip($2) 0adicionado à matéria %ncor $+ $strip($3) $+ 15: %ncor $+ $strip($4) | cx_2 
        }
        halt
      }
      if ($strip($2) == Casa) {
        if ($strip($4) != $null) {
          writeini hp.ini $strip($3) cas $strip($4)
          //set %casa $strip($4)
          cx_1 | inc_m %ncor $+ $strip($3) 0agora pertence a casa: $strip($4) | cx_2 
          msg #Hogwarts 1,1 15,15 00,1 O Chapéu Seletor alterou a casa de15 $strip($3) $+ 00, agora será em $strip($4) $+ 0! 15,15 1,1 
          var %nana = $readini(casas.ini,%casa,alunos)
          writeini casas.ini %casa alunos %nana $+ , $+ $strip($3)
        }
        halt
      }
      if ($strip($2) == Diretor) {
        if ($strip($3) != Corvinal) && ($strip($3) != geral) && ($strip($3) != Grifinória) && ($strip($3) != lufa-lufa) && ($strip($3) != Sonserina) { mc 5Casa não existe na nossa Escola. | halt }
        if ($strip($3) == Corvinal) { var %cr = 02 | var %cas = Corvinal }
        if ($strip($3) == Grifinória) { var %cr = 04 | var %cas = Grifinória }
        if ($strip($3) == Lufa-Lufa) { var %cr = 07 | var %cas = Lufa-Lufa }
        if ($strip($3) == Sonserina) { var %cr = 03 | var %cas = Sonserina }
        if ($strip($4) != $null) {
          writeini casas.ini $strip($3) Diretor $strip($4)
          if ($strip($3) == Geral) { writeini hp.ini $strip($4) car $readini(hp.ini,$strip($4),car) e Diretor Geral }
          else { writeini hp.ini $strip($4) car $readini(hp.ini,$strip($4),car) e Diretor de %cas }
          cx_1 | inc_m %ncor $+ $strip($2) 0adicionado à %ncor $+ $strip($3) $+ 15: %ncor $+ $strip($4) | cx_2 
        }
        halt
      }
      if ($strip($2) == Vice-Diretor) {
        if ($strip($3) != Geral) { cx_1 | inc_m Vice-Diretor só pode ser Geral. | cx_2 | halt }
        if ($strip($4) != $null) {
          writeini casas.ini $strip($3) Vice-Diretor Geral
          cx_1 | inc_m %ncor $+ $strip($2) 0adicionado à %ncor $+ $strip($3) $+ 15: %ncor $+ $strip($4) | cx_2
          writeini hp.ini $strip($4) car $readini(hp.ini,$strip($4),car) e Vice-Diretor Geral
        }
        halt
      }
    }
    if ($strip($1) == !unset) && ($readini(accesshp.ini,$nick,nv) >= 4) {
      if ($strip($2) == Professor) {
        if ($readini(aulas.ini,$strip($3),mat) == $null) { mc 5Matéria não existe na nossa Escola. | halt }
        if ($strip($4) != $null) {
          writeini hp.ini $nick car Estudante
          writeini aulas.ini $strip($3) Professor Nenhum
          mc %cr $+ $strip($3) 5retirado da matéria %cr $+ $strip($2) $+ 7: %cr $+ $strip($4)
        }
        halt
      }
      if ($strip($2) == Diretor) {
        if ($strip($3) != Corvinal) && ($strip($3) != Grifinória) && ($strip($3) != lufa-lufa) && ($strip($3) != Sonserina) { mc 5Casa não existe na nossa Escola. | halt }
        if ($strip($3) == Corvinal) { var %cr = 02 | var %cas = Corvinal }
        if ($strip($3) == Grifinória) { var %cr = 04 | var %cas = Grifinória }
        if ($strip($3) == Lufa-Lufa) { var %cr = 07 | var %cas = Lufa-Lufa }
        if ($strip($3) == Sonserina) { var %cr = 03 | var %cas = Sonserina }
        if ($strip($4) != $null) {
          writeini hp.ini $nick car Estudante
          writeini casas.ini $strip($3) Diretor $null
          mc %cr $+ $strip($2) 5de %cr $+ $strip($3) $+ 5 deletado7: %cr $+ $strip($4)
        }
        halt
      }
      if ($strip($2) == Vice-Diretor) {
        if ($strip($3) != Geral) { mc 5Vice-Diretor só pode ser Geral. | halt }
        if ($strip($4) != $null) {
          writeini hp.ini $nick car Estudante
          writeini casas.ini $strip($3) Vice-Diretor $null
          mc %cr $+ $strip($2) 5de %cr $+ $strip($3) $+ 5 deletado7: %cr $+ $strip($4)
        }
        halt
      }
    }
    if ($strip($1) == !Corujal) {
      var %corn = [ $nick ] $+ .ini
      if ($ini(%corn,0) == 0) {
        writeini %corn A001 msg Seja Bem vindo ao sistema Corujal. Aqui você terá um controle sobre suas mensagens.
        writeini %corn A001 from Hogwarts
        writeini %corn A001 data $date
        writeini %corn A001 read nao
        notice $nick 1,1 %ncor2 0,1 Você acaba de receber uma mensagem em seu Corujal! %ncor2 1,1 
      }
      cx_1
      inc_cx Seja Bem vindo(a) ao Corujal.
      inc_cx O Sistema do Corujal funciona como um simples sistema de mensagens onde você poderá escrever para outros users cadastrados.
      inc_cx 1-
      inc_cx %ncor $+ !15Listar
      inc_cx %ncor $+ !15Ler < $+ %ncor $+ código15>
      inc_cx %ncor $+ !15Deletar < $+ %ncor $+ código15>
      inc_cx %ncor $+ !15Escrever < $+ %ncor $+ nick15> < $+ %ncor $+ mensagem15>
      cx_2
      halt
    }
    if ($strip($1) == !Escrever) && ($strip($3) != $null) {
      var %corn = [ $strip($2) ] $+ .ini
      if ($ini(%corn,0) == 0) { cx_1 | inc_cx Desculpe-me, mas $strip($2) não iniciou o serviço com o Corujal. | cx_2 | halt }
      :reescrevendo_corujal
      var %d1 = $rand(A,Z)
      var %d2 = $calc($ini(%corn,0) + 1)
      if (%d2 < 10) { var %d3 = %d1 $+ $rand(0,9) $+ $rand(0,9) $+ %d2 }
      if (%d2 >= 10) { var %d3 = %d1 $+ $rand(0,9) $+ %d2 }
      if ($readini(%corn,%d3,msg) != $null) { goto reescrevendo_corujal }
      writeini %corn %d3 msg $strip($3-)
      writeini %corn %d3 from $nick
      writeini %corn %d3 data $date
      writeini %corn %d3 read nao
      cx_1
      inc_cx Mensagem enviada à $readini(hp.ini,$strip($2),nick) $+ .
      cx_2
      notice $strip($2) 1,1 14,14 0,1 Você acaba de receber uma mensagem em seu Corujal! 14,14 1,1 
      halt
    }
    if ($strip($1) == !Deletar) { 
      var %corn = [ $nick ] $+ .ini
      if ($ini(%corn,0) == 0) { cx_1 | inc_cx Desculpe-me, mas você não iniciou o serviço com o Corujal. | cx_2 | halt }
      if ($readini(%corn,$strip($2),msg) == $null) { cx_1 | inc_cx Verifique o código novamente, não consigo encontrá-lo. | cx_2 | halt }
      var %cas = $readini(hp.ini,$nick,cas)
      if (%cas == corvinal) { var %cr = 02 | var %cass = Corvinal }
      if (%cas == grifinória) { var %cr = 04 | var %cass = Grifinória }
      if (%cas == lufa-lufa) { var %cr = 07 | var %cass = Lufa-Lufa }
      if (%cas == sonserina) { var %cr = 03 | var %cass = Sonserina }
      remini %corn $strip($2)
      cx_1
      inc_cx Deletada a mensagem de código %ncor $+ $upper($strip($2))
      cx_2
      halt
    }
    if ($strip($1) == !Ler) { 
      var %corn = [ $nick ] $+ .ini
      if ($ini(%corn,0) == 0) { cx_1 | inc_cx Desculpe-me, mas você não iniciou o serviço com o Corujal. | cx_2 | halt }
      if ($readini(%corn,$strip($2),msg) == $null) { cx_1 | inc_cx Verifique o código novamente, não consigo encontrá-lo. | cx_2 | halt }
      cx_1
      inc_m Hogwarts - Corujal
      inc_cx
      inc_cx Código15: %ncor $+ $upper($strip($2))
      inc_cx De15: %ncor $+ $readini(%corn,$strip($2),from) 15( $+ %ncor $+ $readini(%corn,$strip($2),data) $+ 15)
      inc_cx 1-
      inc_m Mensagem
      inc_cx $readini(%corn,$strip($2),msg)
      writeini %corn $strip($2) read sim
      inc_cx 1-
      inc_cx Para deletar a mensagem digite %ncor $+ !15Deletar < $+ %ncor $+ código15>
      cx_2
      halt
    }
    if ($strip($1) == !Listar) { 
      var %corn = [ $nick ] $+ .ini
      if ($ini(%corn,0) == 0) { cx_1 | inc_cx Desculpe-me, mas você não iniciou o serviço com o Corujal. | cx_2 | halt }
      var %x = $ini(%corn,0)
      cx_1
      inc_cx Acessando sua Conta no Corujal...
      inc_cx Listando suas Mensagens:
      inc_cx 1-
      while (%x >= 1) {
        var %cd = $ini(%corn,%x)
        var %au = $readini(%corn,%cd,from)
        var %di = $readini(%corn,%cd,data)
        var %re = $readini(%corn,%cd,read)
        if (%re == nao) { inc_cx Código15: %ncor $+ %cd 15/0 De15: %ncor $+ %au 15( $+ %ncor $+ %di $+ 15) 4NEW }
        if (%re == sim) { inc_cx Código15: %ncor $+ %cd 15/0 De15: %ncor $+ %au 15( $+ %ncor $+ %di $+ 15) }
        var %x = $calc(%x - 1)
      }
      inc_cx 1-
      inc_cx Para ler alguma mensagem, digite %ncor $+ !15Ler < $+ %ncor $+ código15>
      cx_2
      halt
    }
    if ($strip($1) == !Hogsmeade) {
      cx_1
      inc_m Hogsmeade
      inc_cx 1-
      inc_cx %ncor $+ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
      inc_cx Hogsmeade é um vilarejo Bruxo existente no mundo Harry Potter. Aqui você encontrará lojas onde você poderá comprar itens consumíveis. Nossas lojas são:
      inc_cx 1-
      inc_m 15Dedosdemel
      inc_m 15Três Vassouras
      inc_cx 1-
      inc_cx %ncor $+ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
      inc_m Para visitar as lojas, digite %ncor $+ !15Entrar <loja>
      inc_m Você possui $din_x($readini(hp.ini,$nick,gal))
      cx_2
      halt
    }
    if ($strip($1) == !Beco) && ($strip($2) == Diagonal) {
      cx_1
      inc_m Beco Diagonal
      inc_cx 1-
      inc_cx %ncor $+ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
      inc_cx No Beco Diagonal encontram-se lojas onde você comprará coisas como Animais, Vestimenta, Artigos para Quadribol e Varinhas. Nossas lojas são:
      inc_cx 1-
      inc_m 15Animais Mágicos
      inc_m 15Madame Malkin
      inc_m 15Quadribol 
      inc_m 15Olivaras 
      inc_cx 1-
      inc_cx %ncor $+ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
      inc_m Para visitar as lojas, digite %ncor $+ !15Entrar <loja>
      inc_m Você possui $din_x($readini(hp.ini,$nick,gal))
      cx_2
      halt
    }
    if ($strip($1) == !Usar) { 
      var %v_i = $replace($strip($2-),$chr(32),$chr(46))
      var %loc = $readini(loja.ini,%v_i,loja)
      if (%loc != dedosdemel) && (%loc != três vassouras) { cx_1 | inc_cx Item não-consumível, para comprar utilize o comando %ncor $+ !15Comprar | cx_2 | halt }
      var %gal = $readini(hp.ini,$nick,gal)
      var %pre = $readini(loja.ini,%v_i,preco)
      if (%pre > %gal) { cx_1 | inc_cx Desculpe-me, mas parece que você não tem dinheiro suficiente para usar esse item. | cx_2 | halt }
      var %por = $int($calc(%pre / 10))
      var %vig = $readini(hp.ini,$nick,vig)
      var %nvig = $calc(%vig + %por)
      if (%nvig > 100) { var %nvig = 100 }
      writeini hp.ini $nick vig %nvig
      writeini hp.ini $nick gal $calc(%gal - %pre)
      if (%v_i == Sapo.de.chocolate) { 
        cx_1
        inc_cx      5m3/¯¯¯¯3\5m 
        inc_cx      3\  5''  3/     0Você comeu um 03Sapo de Chocolate
        inc_cx       3\    /        0e recuperou 0325% 0do seu Vigor
        inc_cx       3/ __ \                 0Físico.
        inc_cx       5W    W
        cx_2
      }
      if (%v_i == Feijõezinhos.de.todos.os.sabores) { 
        cx_1
        inc_cx       5/¯¯\  
        inc_cx      0/0|   5|     0Você comeu 5Feijõezinhos de Todos
        inc_cx     0/3,0/   5|      5os Sabores 0e recuperou 0545% 0do
        inc_cx     0\0/   5/          0seu Vigor Físico.
        inc_cx      5\__/
        cx_2
      }
      if (%v_i == Cerveja.Amanteigada) { 
        cx_1
        inc_cx     7 ,,,,
        inc_cx     5|7~~~~5|¯|     00Você tomou uma taça de 7Cerveja
        inc_cx     5|  7. 5| |     7Amanteigada 0e recuperou 0765%
        inc_cx     5| 7. .5|¯         0do seu Vigor Físico.
        inc_cx     5 ¯¯¯¯
        cx_2
      }
      if (%v_i == Hidromel) { 
        cx_1
        inc_cx       7____
        inc_cx      7/    \     00Você tomou um copo de 05Hidromel 00e
        inc_cx     7| 5~~~~ 7|       00recuperou 0580% 00do seu Vigor
        inc_cx     7| 5~~~~ 7|                00Físico.
        inc_cx      7\____/
        cx_2
      }
      if (%v_i == Uísque.de.fogo) { 
        cx_1
        inc_cx   4~'~
        inc_cx    4'~'14____     00Você tomou um copo de 4Uísque de
        inc_cx      14|4~~~~14|      4Fogo 00e recuperou 0490% 00do seu
        inc_cx      14|    |             00Vigor Físico.
        inc_cx      14|____|
        cx_2
      }
      halt
    }
    if ($strip($1) == !Comprar) { 
      var %v_i = $replace($strip($2-),$chr(32),$chr(46))
      var %loc = $readini(loja.ini,%v_i,loja)
      if (%loc == Olivaras) {
        var %pre = $readini(loja.ini,%v_i,preco)
        var %it = $readini(loja.ini,%v_i,var)
        var %gal = $readini(hp.ini,$nick,gal)
        if (%pre > %gal) { cx_1 | inc_cx Desculpe-me, mas parece que você não tem dinheiro suficiente para comprar essa Varinha. | cx_2 | halt }
        writeini hp.ini $nick oldv $readini(hp.ini,$nick,var)
        writeini hp.ini $nick var %it
        writeini hp.ini $nick gal $calc(%gal - %pre)
        writeini hp.ini $nick ite $readini(hp.ini,$nick,ite) $+ ,Varinha Mágica
      }
      if (%loc == Animais Mágicos) {
        var %pre = $readini(loja.ini,%v_i,preco)
        var %gal = $readini(hp.ini,$nick,gal)
        if (%pre > %gal) { cx_1 | inc_cx Desculpe-me, mas parece que você não tem dinheiro suficiente para comprar esse Animal Mágico. | cx_2 | halt }
        writeini hp.ini $nick ani $strip($2)
        writeini hp.ini $nick gal $calc(%gal - %pre)
        writeini hp.ini $nick ite $readini(hp.ini,$nick,ite) $+ , $+ $strip($2)
      }
      if (%loc == Madame Malkin) {
        var %pre = $readini(loja.ini,%v_i,preco)
        var %gal = $readini(hp.ini,$nick,gal)
        if (%pre > %gal) { cx_1 | inc_cx Desculpe-me, mas parece que você não tem dinheiro suficiente para comprar essa Vestimenta. | cx_2 | halt }
        writeini hp.ini $nick ves $strip($2-)
        writeini hp.ini $nick gal $calc(%gal - %pre)
        writeini hp.ini $nick ite $readini(hp.ini,$nick,ite) $+ , $+ $strip($2-)
      }
      if (%loc == Quadribol) {
        var %pre = $readini(loja.ini,%v_i,preco)
        var %gal = $readini(hp.ini,$nick,gal)
        if (%pre > %gal) { mc 5Desculpe-me, mas parece que você não tem dinheiro suficiente para comprar esse Equipamento. | halt }
        writeini hp.ini $nick ite $readini(hp.ini,$nick,ite) $+ , $+ $strip($2-)
        writeini hp.ini $nick gal $calc(%gal - %pre)
      }
      if (%loc == dedosdemel) { cx_1 | inc_cx Item consumível, para comprar utilize o comando %ncor $+ !15Usar | cx_2 | halt }
      if (%loc == três.vassouras) { cx_1 | inc_cx Item consumível, para comprar utilize o comando %ncor $+ !15Usar | cx_2 | halt }
      cx_1
      inc_cx Você acabou de comprar o item15: %ncor $+ $strip($2-)
      inc_cx Gastando assim $din_x(%pre)
      inc_cx Você ficou com $din_x($readini(hp.ini,$nick,gal))
      cx_2
      halt
    }
    if ($strip($1) == !Liberar) { //soltar_pris | halt }
    if ($strip($1) == !Horário) {
      cx_1
      inc_m Horário das Aulas
      inc_m %ncor $+ ¯¯¯¯¯¯¯ ¯¯¯ ¯¯¯¯¯
      inc_cx 00     Hora    15,14 0,1  Sábado           15,14 0,1  Domingo
      inc_cx 14     ¯¯¯¯¯¯¯¯15,14 14,1¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯14,14 14,1¯¯¯¯¯¯¯¯¯
      inc_cx 00     14:00h  15,14 0,1  -                15,14 0,1  Herbologia
      inc_cx 15     15:00h  15,14 15,1  Transfiguração   15,14 15,1  Poções
      inc_cx 00     16:00h  15,14 0,1  História da M.   15,14 0,1  -
      inc_cx 15     19:00h  15,14 15,1  -                15,14 15,1  D.C. as Artes Trevas
      inc_cx 00     20:00h  15,14 0,1  Astronomia       15,14 0,1  -
      inc_cx 15     21:00h  15,14 15,1  Feitiços         15,14 15,1  Quadribol
      cx_2
      halt
    }
    if ($strip($1) == !Quote) && ($readini(accesshp.ini,$nick,nv) >= 2) {
      if ($strip($2) == Add) {
        var %pn = $readini(cont.ini,quote,num)
        var %pn2 = $calc(%pn + 1)
        writeini quote.ini %pn2 quo $3- 
        writeini quote.ini %pn2 data $date
        writeini cont.ini quote num %pn2
        var %quo = $readini(quote.ini,%pn2,quo)
        var %dt = $readini(quote.ini,%pn2,data)
        mc 5Quote Adicionada7: %quo 5(07 $+ %dt $+ 5)
        halt
      }
      if ($strip($2) == Del) {
        if ($readini(quote.ini,$strip($3),quo) == $null) { mc 5Quote não encontrada. | halt }
        mc 5Quote Removida7: $strip($3)
        remini quote.ini $strip($3)
      }
      halt
    }
    if ($strip($1) == !quotes) {
      cx_1
      inc_m Comando Desativado por tempo indeterminado 15;P
      cx_2
      halt
      var %top1 = $ini(quote.ini,0)
      if (%top1 != 0) { 
        mc 5Listando as quotes de Hogwarts.
        var %p = 1
        while (%p <= %top1) {
          var %ti = $ini(quote.ini,%p)
          mc 5Quote 07 $+ $ini(quote.ini,%p) $+ 5:07 $readini(quote.ini,%ti,quo) 5(07 $+ $readini(quote.ini,%ti,data) $+ 5)
          inc %p
        }
      }
      else { mc 5Não há quote adicionada. | halt }
      halt
    }
    if ($strip($1) == !Pontos) && ($readini(accesshp.ini,$nick,nv) >= 3) {
      if ($readini(casas.ini,$strip($2),Pontos) == $null) { mc 5Essa casa não existe em nossa escola. | halt }
      if ($readini(hp.ini,$strip($3),nick) == $null) { mc 5O Nick informado não está matriculado em nossa escola. | halt }
      if ($4 == $null) { mc 5Faltando dados. | halt }
      writeini casas.ini $strip($2) pontos $calc($readini(casas.ini,$strip($2),pontos) + $strip($4))
      writeini hp.ini $strip($3) pts $calc($readini(hp.ini,$strip($3),pts) + $strip($4))
      mc 5Pontos adicionados à07 $strip($2) 5:7 $strip($4) $+ 5,07 $strip($3)
      halt
    }
    if ($strip($1) == !info) { 
      var %item = $replace($strip($2-),$chr(32),$chr(46))
      if ($readini(loja.ini,%item,desc) == $null) { cx_1 | inc_cx Item/Animal não encontrado. | cx_2 | halt }
      cx_1
      inc_m Hogwarts - Informações
      inc_cx 1-
      inc_cx Informação15: %ncor $+  $+ $strip($2-) $+ 
      inc_cx Categoria15: %ncor $+  $+ $readini(loja.ini,%item,tipo) $+ 
      inc_cx 1-
      if ($readini(loja.ini,%item,tipo) == Varinha Mágica) {
        inc_m Nome da Varinha Mágica
        inc_cx $readini(loja.ini,%item,var)
        inc_cx 1-
      }
      inc_m Descrição
      inc_cx $readini(loja.ini,%item,desc)
      cx_2
      halt
    }
    ;if ($strip($1) == !cmd) && ($readini(accesshp.ini,$nick,nv) { // $+ $strip($2-) | halt }
    if ($strip($1) == !Entrar) {
      var %local = $replace($strip($2-),$chr(32),$chr(46))
      if (%local != Dedosdemel) && (%local != Três.Vassouras) && (%local != Animais.Mágicos) && (%local != Animais.Magicos) && (%local != Madame.Malkin) && (%local != Quadribol) && (%local != Olivaras) { cx_1 | inc_cx Local inexistente15:04 $strip($2-) | halt }
      if (%local == Animais.Mágicos) {
        cx_1
        inc_cx %ncor $+ $nick $+ 00, seja bem vindo(a) a Loja de Animais Mágicos!
        inc_cx Veja abaixo os Animais que temos disponíveis.
        inc_cx 1-
        inc_cx %ncor2 $+ 1Animal $+ $str($chr(160),35) 1,1 %ncor2 1Preço         1,1
        var %x1 = 1
        var %x2 = $ini(loja.ini,0)
        while (%x1 <= %x2) { 
          var %anim = $ini(loja.ini,%x1)
          if ($readini(loja.ini,%anim,loja) == Animais Mágicos) { 
            var %animal = $replace(%anim,$chr(46),$chr(32))
            inc_cx %animal $+ $str($chr(160),$calc(43 - $len(%anim))) $din_x($readini(loja.ini,%anim,preco))
          }
          inc %x1
        }
        inc_cx 1-
        inc_cx Para ver alguma informação/descrição do animal desejado, digite %ncor $+ !15Info %ncor $+ '15Animal $+ %ncor $+ '
        inc_cx Para comprar, digite %ncor $+ !15Comprar %ncor $+ '15Animal $+ %ncor $+ '
        inc_m Você tem %ncor $+ $din_x($readini(hp.ini,$nick,gal))
        cx_2
        halt
      }
      if (%local == Animais.Magicos) {
        cx_1
        inc_cx %ncor $+ $nick $+ 00, seja bem vindo(a) a Loja de Animais Mágicos!
        inc_cx Veja abaixo os Animais que temos disponíveis.
        inc_cx 1-
        inc_cx %ncor2 $+ 1Animal $+ $str($chr(160),35) 1,1 %ncor2 1Preço         1,1
        var %x1 = 1
        var %x2 = $ini(loja.ini,0)
        while (%x1 <= %x2) { 
          var %anim = $ini(loja.ini,%x1)
          if ($readini(loja.ini,%anim,loja) == Animais Mágicos) { 
            var %animal = $replace(%anim,$chr(46),$chr(32))
            inc_cx %animal $+ $str($chr(160),$calc(43 - $len(%anim))) $din_x($readini(loja.ini,%anim,preco))
          }
          inc %x1
        }
        inc_cx 1-
        inc_cx Para ver alguma informação/descrição do animal desejado, digite %ncor $+ !15Info %ncor $+ '15Animal $+ %ncor $+ '
        inc_cx Para comprar, digite %ncor $+ !15Comprar %ncor $+ '15Animal $+ %ncor $+ '
        inc_m Você tem %ncor $+ $din_x($readini(hp.ini,$nick,gal))
        cx_2
        halt
      }
      if (%local == Madame.Malkin) {
        cx_1
        inc_cx %ncor $+ $nick $+ 00, seja bem vindo(a) a Loja da Madame Malkin Roupas Para Todas as Ocasiões.
        inc_cx Veja abaixo as vestimentas que temos disponíveis.
        inc_cx 1-
        inc_cx %ncor2 $+ 1Vestimenta $+ $str($chr(160),31) 1,1 %ncor2 1Preço         1,1
        var %x1 = 1
        var %x2 = $ini(loja.ini,0)
        while (%x1 <= %x2) { 
          var %anim = $ini(loja.ini,%x1)
          if ($readini(loja.ini,%anim,loja) == Madame Malkin) { 
            var %animal = $replace(%anim,$chr(46),$chr(32))
            inc_cx %animal $+ $str($chr(160),$calc(43 - $len(%anim))) $din_x($readini(loja.ini,%anim,preco))
          }
          inc %x1
        }
        inc_cx 1-
        inc_cx Para ver alguma informação da vestimenta desejada, digite %ncor $+ !15Info %ncor $+ '15Vestimenta $+ %ncor $+ '
        inc_cx Para comprar, digite %ncor $+ !15Comprar %ncor $+ '15Vestimenta $+ %ncor $+ '
        inc_m Você tem %ncor $+ $din_x($readini(hp.ini,$nick,gal))
        cx_2
        halt
      }
      if (%local == Quadribol) {
        cx_1
        inc_cx %ncor $+ $nick $+ 00, seja bem vindo(a) a Loja de Artigos para Quadribol.
        inc_cx Veja abaixo os equipamentos que temos disponíveis.
        inc_cx 1-
        inc_cx %ncor2 $+ 1Item $+ $str($chr(160),36) 1,1 %ncor2 1Preço         1,1
        var %x1 = 1
        var %x2 = $ini(loja.ini,0)
        while (%x1 <= %x2) { 
          var %anim = $ini(loja.ini,%x1)
          if ($readini(loja.ini,%anim,loja) == Quadribol) { 
            var %animal = $replace(%anim,$chr(46),$chr(32))
            inc_cx %animal $+ $str($chr(160),$calc(43 - $len(%anim))) $din_x($readini(loja.ini,%anim,preco))
          }
          inc %x1
        }
        inc_cx 1-
        inc_cx Para ver alguma informação do item desejado, digite %ncor $+ !15Info %ncor $+ '15Item $+ %ncor $+ '
        inc_cx Para comprar, digite %ncor $+ !15Comprar %ncor $+ '15Item $+ %ncor $+ '
        inc_m Você tem %ncor $+ $din_x($readini(hp.ini,$nick,gal))
        cx_2
        halt
      }
      if (%local == Dedosdemel) {
        cx_1
        inc_cx %ncor $+ $nick $+ 00, seja bem vindo(a) a Loja de doces Dedosdemel.
        inc_cx Veja abaixo os doces que temos disponíveis.
        inc_cx 1-
        inc_cx %ncor2 $+ 1Item $+ $str($chr(160),36) 1,1 %ncor2 1Preço         1,1
        var %x1 = 1
        var %x2 = $ini(loja.ini,0)
        while (%x1 <= %x2) { 
          var %anim = $ini(loja.ini,%x1)
          if ($readini(loja.ini,%anim,loja) == dedosdemel) { 
            var %animal = $replace(%anim,$chr(46),$chr(32))
            inc_cx %animal $+ $str($chr(160),$calc(43 - $len(%anim))) $din_x($readini(loja.ini,%anim,preco))
          }
          inc %x1
        }
        inc_cx 1-
        inc_cx Para ver alguma informação do item desejado, digite %ncor $+ !15Info %ncor $+ '15Item $+ %ncor $+ '
        inc_cx Para comer, digite %ncor $+ !15Usar %ncor $+ '15Item $+ %ncor $+ '
        inc_m Você tem %ncor $+ $din_x($readini(hp.ini,$nick,gal))
        cx_2
        halt
      }
      if (%local == três.Vassouras) {
        cx_1
        inc_cx %ncor $+ $nick $+ 00, seja bem vindo(a) a Loja Três Vassouras.
        inc_cx Veja abaixo as bebidas que temos disponíveis.
        inc_cx 1-
        inc_cx %ncor2 $+ 1Item $+ $str($chr(160),36) 1,1 %ncor2 1Preço         1,1
        var %x1 = 1
        var %x2 = $ini(loja.ini,0)
        while (%x1 <= %x2) { 
          var %anim = $ini(loja.ini,%x1)
          if ($readini(loja.ini,%anim,loja) == três vassouras) { 
            var %animal = $replace(%anim,$chr(46),$chr(32))
            inc_cx %animal $+ $str($chr(160),$calc(43 - $len(%anim))) $din_x($readini(loja.ini,%anim,preco))
          }
          inc %x1
        }
        inc_cx 1-
        inc_cx Para ver alguma informação do item desejado, digite %ncor $+ !15Info %ncor $+ '15Item $+ %ncor $+ '
        inc_cx Para beber, digite %ncor $+ !15Usar %ncor $+ '15Item $+ %ncor $+ '
        inc_m Você tem %ncor $+ $din_x($readini(hp.ini,$nick,gal))
        cx_2
        halt
      }
      if (%local == Olivaras) {
        writeini hp.ini $nick local Olivaras
        if ($readini(hp.ini,$nick,viso) == $null) {
          cx_1
          inc_cx [Sr. Olivaras]
          inc_cx - Olá %ncor $+ $nick $+ 00, você vem aqui pela primeira vez não é?
          inc_cx Hmmm, você veio da casa de %ncor $+ $readini(hp.ini,$nick,cas) $+ 00... Interessante...
          inc_cx Vamos arrumar uma varinha perfeita para você... Pegue essa varinha.
          inc_cx 6* $nick pega a varinha
          inc_cx 6* Sr. Olivaras Toma a varinha das mãos dele com um 
          inc_cx 6movimento brusco e uma caixinha cai no chão
          inc_cx - Não, essa definitivamente não é a sua. - Diz Sr. Olivaras - Hmmm... o que?
          inc_cx 6* Olivaras pega a varinha da caixinha no chão e entrega 6para $nick $+ .
          inc_cx - Segure essa...
          inc_cx 6* $nick pega a varinha e quase no mesmo momento Sr. Olivaras diz:
          inc_cx - Sim! Essa é a sua varinha! Com toda certeza que é! 
          var %rand = $rand(1,16)
          if (%rand == 1) { var %vara = Bétula e Corda de Coração de Dragão, 41 cm, muito grossa, inflexível. }
          if (%rand == 2) { var %vara = Pelo de unicórnio, 21 cm, Carvalho e farfalhante. }
          if (%rand == 3) { var %vara = Pena de Fênix, 32 cm, Pinheiro, farfalhante. }
          if (%rand == 4) { var %vara = Pelo de unicórnio, 23 cm, Faia, fina. }
          if (%rand == 5) { var %vara = Corda de Coração de Dragão, 29 cm, Ipê, meio mole. }
          if (%rand == 6) { var %vara = Pena da Cauda de Fênix, 33 cm, Palmeira, meio grossa. }
          if (%rand == 7) { var %vara = Corda de Coração de Dragão, 35 cm, Jequetibão, fina. }
          if (%rand == 8) { var %vara = Pelo de Unicórnio, 21 cm, Mogno, maleável. }
          if (%rand == 9) { var %vara = Pena de Fênix, 41 cm, Cedro, maleável e farfalhante. }
          if (%rand == 10) { var %vara = Pelo de Unicórnio, 19 cm, Bálsamo, meio mole. }
          if (%rand == 11) { var %vara = Corda de Coração de Dragão, 37 cm, Salgueiro, meio grossa. }
          if (%rand == 12) { var %vara = Pena de Fênix, 26 cm, Paineira, maleável. }
          if (%rand == 13) { var %vara = Pelo de Unicórnio, 36 cm, Peroba, farfalhante. }
          if (%rand == 14) { var %vara = Corda de Coração de Dragão, 39 cm, Mangueira, fina. }
          if (%rand == 15) { var %vara = Pena de Fênix, 38 cm, Madeira Negra, meio grossa. }
          if (%rand == 16) { var %vara = Pelo de Unicórnio, Araucaria, 41 cm, fina. }
          inc_cx - %vara $+ ... Simplesmente perfeita para você.
          writeini hp.ini $nick var %vara
          writeini hp.ini $nick viso 1
          writeini hp.ini $nick ite $readini(hp.ini,$nick,ite) $+ ,Varinha Mágica
          inc_cx 1-
          inc_cx Após pagar pela sua varinha, $nick vai para Hogwarts.
          writeini hp.ini $nick local Sala Comunal de $readini(hp.ini,$nick,cas)
          inc_cx Você se encontra agora na $readini(hp.ini,$nick,local)
          cx_2
          halt
        }
        if ($readini(hp.ini,$nick,viso) != $null) {
          cx_1
          inc_cx %ncor $+ $nick $+ 00, seja bem vindo(a) a Loja Sr. Olivaras.
          inc_cx Veja abaixo as Varinhas Mágicas que temos disponíveis.
          inc_cx 1-
          inc_cx %ncor2 $+ 1Item $+ $str($chr(160),36) 1,1 %ncor2 1Preço         1,1
          var %x1 = 1
          var %x2 = $ini(loja.ini,0)
          while (%x1 <= %x2) { 
            var %anim = $ini(loja.ini,%x1)
            if ($readini(loja.ini,%anim,loja) == Olivaras) { 
              var %animal = $replace(%anim,$chr(46),$chr(32))
              inc_cx %animal $+ $str($chr(160),$calc(43 - $len(%anim))) $din_x($readini(loja.ini,%anim,preco))
            }
            inc %x1
          }
          inc_cx 1-
          inc_cx Para ver alguma informação do item desejado, digite %ncor $+ !15Info %ncor $+ '15Item $+ %ncor $+ '
          inc_cx Para comprar, digite %ncor $+ !15Comprar %ncor $+ '15Item $+ %ncor $+ '
          inc_m Você tem %ncor $+ $din_x($readini(hp.ini,$nick,gal))
          cx_2
          halt

          halt
        } 
        halt
      }
    }
    set %fala $strip($1-)
    $chat_hp
  }
}
on *:part:#Hogwarts: {
  if ($readini(accesshp.ini,$nick,st) == temp) { remini accesshp.ini $nick }
  if ($readini(hp.ini,$nick,nick) != $null) {
    writeini hp.ini $nick id off
  }
  if ($readini(hp.ini,$nick,nick) == $null) {
    remini hp.ini $nick
  }
  inc_cx Conexão fechada15:0 Você saiu do canal
  //close -c $nick 
}
on *:close:=: {
  if ($readini(hp.ini,$nick,lob2) == on) { 
    writeini hp.ini $nick lob2 off
  }
  //close -c $nick
  if ($readini(hp.ini,$nick,nick) == $null) {
    remini hp.ini $nick
  }
}
