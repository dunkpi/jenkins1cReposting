Run("C:\Program Files (x86)\1Cv77\BIN\1cv7s.exe ENTERPRISE /D" & $CmdLine[1] & " /N" & $CmdLine[2] & " /P" & $CmdLine[3])

$titMain = "ITek 2003:"
$titObrab = "(repost)"
$titObrabFinished = "(finished)"

Opt("WinTitleMatchMode", 2)
WinWaitActive($titMain)
SendKey("{ALT}")
SendKey("{RIGHT}")
SendKey("{DOWN}")
SendKey("{UP}", 2)
SendKey("{ENTER}")
WinWaitActive($titMain, $titObrab)
SendKey(StringRight($CmdLine[4], 2) & StringMid($CmdLine[4], 5, 2) & StringMid($CmdLine[4], 3, 2))
SendKey("{TAB}")
SendKey(StringRight($CmdLine[5], 2) & StringMid($CmdLine[5], 5, 2) & StringMid($CmdLine[5], 3, 2))
SendKey("{TAB}", 9)
SendKey("{SPACE}")
SendKey("{TAB}", 11)
SendKey("{SPACE}")
SendKey("{TAB}", 6)
$pathArray = StringSplit($CmdLine[6], "\")
SendKey($CmdLine[6] & $pathArray[UBound($pathArray) - 2])
SendKey("{TAB}")
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