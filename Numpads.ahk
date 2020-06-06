#NoEnv
#SingleInstance force
Menu, Tray, Icon, %A_ScriptDir%\Icons\Mouse.ico
SetTitleMatchMode, RegEx

; if I pressed the given key for 500ms then return true, otherwise return false
longPressed(key)
    {
        startTime := A_TickCount
        KeyWait, %key%
        if scrolled(){
            return False
        }
        else if (A_TickCount - startTime > 500) {
            startTime := 0
            return True
        }
        return false

; if I scrolled with the scroll wheel return true, otherwise return false
scrolled(){
    if (A_PriorKey = "WheelUp") || (A_PriorKey = "WheelDown") || (A_ThisHotKey = "WheelDown")|| (A_ThisHotKey = "Wheelup")
        return True
    return false
}

; save the page and reload the script
~^s::
Reload
return

; launch the start menu if I haven't scrolled
F13::
Keywait, F13
if !scrolled()
    Send {LWin}
return

; switch the previous window if I haven't scrolled
F14::
Keywait F14
If !scrolled()
    send, #{Tab}
return

; If I'm at YouTube or praxis then send F to make the video full screen, otherwise send F11 to make the window full screen
F15::
Keywait, F15
if !scrolled() {
    IfWinActive, .*YouTube|.*Praxis Portal
    {
        Send, f
        return
    }
    Send, {F11}
}

; open the alt-tab menu while I hold this down and close it when I release
F16::
Send, {LAlt Down}{Tab}
KeyWait F16
SendInput, {LAlt Up}
return

; if I longpress this button and didn't scroll, refresh the browser window
; if I haven't scrolled and the browser is the focused window open a new tab
; if I haven't scrolled and the browser isn't focused but exists, focus the browser window
; otherwise just open a new browser window
F17::
if (longPressed("F17") && !scrolled()) {
    IfWinActive, .*Edge
    {
        Send, {F5}
        return
    }
}
KeyWait, F17
if !scrolled() {
    IfWinActive .*Edge
    {
        Send, ^t
        SoundPlay, C:\Windows\media\Windows Feed Discovered.wav
        WinWait, Speed Dial
    }
    else IfWinExist, .*Edge
    {
        WinActivate, .*Edge
        WinWait, .*Edge
    }
    else
        Run, C:\Program Files (x86)\Microsoft\Edge\Application\msedge_proxy.exe --profile-directory=Default
}
return

F18::
