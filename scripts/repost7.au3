Run("C:\Program Files (x86)\1Cv77\BIN\1cv7s.exe ENTERPRISE /D" & $CmdLine[1] & " /N" & $CmdLine[2] & " /P" & $CmdLine[3])

$titMain = "1С:Предприятие"
$titObrab = "Обработка документов"
$titObrabFinished = "Обработка закончена!"

WinWaitActive($titMain)
SendKey("{ALT}")
SendKey("{RIGHT}")
SendKey("{DOWN}")
SendKey("{UP}", 2)
SendKey("{ENTER}")
WinWaitActive($titMain, $titObrab)
SendKey($CmdLine[4])
SendKey("{TAB}")
SendKey($CmdLine[5])
SendKey("{TAB}", 9)
SendKey("{SPACE}")
SendKey("{TAB}", 11)
SendKey("{SPACE}")
SendKey("{TAB}", 6)
SendKey("{SPACE}")
WinWaitActive($titMain, $titObrabFinished)
SendKey("{SPACE}")
SendKey("{ESC}")
WinClose($titMain)
SendKey("{SPACE}")

Func SendKey($key, $count = 1)
    For $i = 1 To $count Step 1
        Sleep(200)
        Send($key)
    Next
EndFunc