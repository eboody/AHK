#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

gitCommit()
{
    InputBox, message, "Message", "Input commit message"
    Reload
    ; gitAdd := "git add " . A_ScriptDir . "\" . A_ScriptName
    gitAdd := "git add -A"
    RunWait, C:\Program Files\Git\git-cmd.exe "%gitAdd% && git commit -m " %message% " && git push && exit"
}