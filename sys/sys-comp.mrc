on *:text:@Participar*:#: {
  if (%aula.ativo != sim) { halt }
  if ($readini(hp.ini,$nick,nick) == $null) { halt }
  if ($readini(hp.ini,$nick,vig) == 0) { notice $nick 1,1 14,14 0,1 Você está sem vigor. 14,14 1,1  | halt }
  if ($readini(hp.ini,$nick,treinando) == sim) {  notice $nick 1,1 14,14 0,1 Você está treinando. 14,14 1,1  | cx_2 | halt }
  if ($nick isin $readini(aula.ini,%aula,participou)) { halt }
  var %cas = $readini(hp.ini,$nick,cas)
  if (%cas == corvinal) { var %cr = 11 | var %cr2 = 11,11 | var %cass = Corvinal }
  if (%cas == grifinória) { var %cr = 04 | var %cr2 = 04,04 | var %cass = Grifinória }
  if (%cas == lufa-lufa) { var %cr = 08 | var %cr2 = 08,08 | var %cass = Lufa-Lufa }
  if (%cas == sonserina) { var %cr = 09 | var %cr2 = 09,09 | var %cass = Sonserina }
  set %d1 $rand(1,6)
  if (%d1 = 1) { set %desempenho péssimo | set %aula.magia 5 | set %aula.casa 0 | set %msg 1,1 14,14 0,1 %prof $+ 0: "Você precisa se dedicar mais,15 $Nick $+ 0!" 14,14 1,1  }
  if (%d1 = 2) { set %desempenho fraco | set %aula.magia 7 | set %aula.casa 3 | set %msg 1,1 14,14 0,1 %prof $+ 0: "Mais %aula.casa pontos para %cr $+ %cass $+ 00!" 14,14 1,1  }
  if (%d1 = 3) { set %desempenho razoável | set %aula.magia 10 | set %aula.casa 5 | set %msg 1,1 14,14 0,1 %prof $+ 0: "Mais %aula.casa pontos para %cr $+ %cass $+ 00!" 14,14 1,1  }
  if (%d1 = 4) { set %desempenho bom | set %aula.magia 12 | set %aula.casa 7 | set %msg 1,1 14,14 0,1 %prof $+ 0: "Mais %aula.casa pontos para %cr $+ %cass $+ 00!" 14,14 1,1  }
  if (%d1 = 5) { set %desempenho ótimo | set %aula.magia 13 | set %aula.casa 10 | set %msg 1,1 14,14 0,1 %prof $+ 0: "Mais %aula.casa pontos para %cr $+ %cass $+ 00!" 14,14 1,1  }
  if (%d1 = 6) { set %desempenho excelente | set %aula.magia 15 | set %aula.casa 12 | set %msg 1,1 14,14 0,1 %prof $+ 0: "Mais %aula.casa pontos para %cr $+ %cass $+ 00!" 14,14 1,1  }
  msg #Hogwarts 1,1 14,14 07,1 $nick 0participou da aula e teve um desempenho15 %desempenho $+ . 15Recompensa0:07 + $+ %aula.magia 0de Magia. 14,14 1,1 
  msg #Hogwarts %msg
  var %caspts = $readini(casas.ini,%cas,pontos)
  var %mag = $readini(hp.ini,$nick,mag)
  var %pts = $readini(hp.ini,$nick,pts)
  var %cas = $readini(hp.ini,$nick,cas)
  writeini hp.ini $nick mag $calc(%mag + %aula.magia)
  writeini hp.ini $nick pts $calc(%pts + %aula.casa)
  writeini casas.ini %cas pontos $calc(%caspts + %aula.casa)
  writeini aula.ini %aula participou $nick $readini(aula.ini,%aula,participou)
  if (%d1 == 1) { 
    var %pevig2 = $rand(2,10)
    var %pts2 = $readini(hp.ini,$nick,pts)
    var %cas2 = $readini(hp.ini,$nick,cas)
    var %caspts2 = $readini(casas.ini,%cas,pontos)
    writeini hp.ini $nick vig $calc($readini(hp.ini,$nick,vig) - %pevig2)
    writeini hp.ini $nick pts $calc(%pts2 - %pevig2)
    writeini casas.ini %cas2 pontos $calc(%caspts2 - %pevig2)
    msg #Hogwarts 1,1 14,14 0,1 %prof $+ 0: "Menos %pevig2 pontos para %cr $+ %cass $+ 00!" 14,14 1,1 
    msg #Hogwarts  1,1 14,14 07,01 $nick 0perdeu vigor. 14,14 1,1 
  halt }
}

alias aula.inicio { 
  inc %contagemaula
  set %aula.ativo sim
  set %aula $ini(aula.ini,$rand(1,$ini(aula.ini,0)))
  set %prof $readini(aula.ini,%aula,prof)
  set %local $readini(aula.ini,%aula,local)
  set %tema $readini(aula.ini,%aula,tema)
  set %intro $readini(aula.ini,%aula,intro)
  set %conteudo $readini(aula.ini,%aula,conteúdo)
  msg #Hogwarts 1,1 14,14 0,1 Aula(15 $+ %contagemaula $+ 0) de07 $readini(aula.ini,%aula,aula) 0 $+ %local 0com %prof 0iniciando agora. 14,14 1,1 
  msg #Hogwarts 1,1 14,14 0,1 %prof $+ 0:15 " $+ %intro $+ " 14,14 1,1 
  msg #Hogwarts 1,1 14,14 0,1 %prof $+ 0: "O tema da aula de hoje é15 %tema $+ !" 14,14 1,1 
  msg #Hogwarts 1,1 14,14 0,1 %prof $+ 0:15 " $+ %conteudo $+ " 14,14 1,1 
  msg #Hogwarts 1,1 14,14 0,1 Para participar da aula digite 12@15Participar 14,14 1,1 
  remini aula.ini %aula participou
  timeraula 1 150 aula.fim
}
alias aula.fim {
  remini aula.ini %aula participou
  msg #Hogwarts 1,1 14,14 0,1 %prof $+ 0: "Aula 15encerrada0!" 14,14 1,1 
  /set %antesaula 20400
  /timernovaaula  1 %antesaula //aula.inicio
  /timeravisoaula 1 $calc(%antesaula - 60) //aviso.aula
  set %aula.ativo nao
  unset %aula
}

alias aviso.aula {  msg #Hogwarts 1,1 14,14 0,1 Em07 1 15minuto0 comecará uma nova aula em Hogwarts. Fique atento15! 14,14 1,1  }

alias tempo_certo {
  var %t = $duration($1)
  %t = $replace(%t,wk,semana,day,dia,hr,hora,min,minuto,sec,segundo)
  %t = $mid($regsubex(%t,/([0-9]+)([a-z]+)/g,\1 \2 $+ $chr(44)),1,-1)
  if ($1 > 60) %t = $gettok(%t,1- $+ $calc($numtok(%t,44) - 1),44) e $gettok(%t,$numtok(%t,44),44)
  return %t
}

on *:text:@Unir*:#Hogwarts: { msg $chan 14União entre 3'2 $2 15e13 $3 3' 14depois de nove meses dá: 4· $+ 12 $+ $left($2,3) $+ $right($3,2) $+ 4· }
