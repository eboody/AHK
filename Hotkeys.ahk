#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

	!Backspace::
	Send, Delete
	return

insert::return ;Run, devcon enable "@HID\DLL06E4&COL02\5&3044424B&0&0001"
	Pause:: 
	Run taskmgr.exe
	return
	PgUp:: 
		IfWinActive .*YouTube.* || .*mpv.*
		{
			Send, {Volume_Up}{Volume_Up}
		}
		return

	PgDn:: 
		IfWinActive .*YouTube.* || .*mpv.*
		{
			Send, {Volume_Down}{Volume_Down}	
		}
		return

	^PgUp:: 
		IfWinActive .*YouTube.* 
		{
			Send, {PgUp}
		}
		return

	^PgDn::
		IfWinActive .*YouTube.*
		{
			Send, {PgDn}
		}
		return

;;******  Caps Lock
	CapsLock::return
	CapsLock & LButton::
		Send {LButton}
		Send {AppsKey}
		Sleep, 50
		Send {Enter}
	return
	CapsLock & d::
		If GetKeyState("Shift", "P"){
			Send, +{End}
			return
		}
		Send, {End}
		return

	CapsLock & a::
		If GetKeyState("Shift", "P"){
			Send, +{Home}
			return
		}
		Send, {Home}
		return

	CapsLock & s::
		If GetKeyState("Shift", "P"){
			Send, +{End}
			return
		}
		Send, {Down}
		return

	CapsLock & w::
		Send, ^{Left}
		Send, ^+{Right}
		return
	
	CapsLock & h::
		Run, C:\Users\ebood\OneDrive\Portable Apps\nircmd-x64\nircmd.exe win togglehide class Shell_TrayWnd
		return


;;******  WINDOWS KEY + H TOGGLES HIDDEN FILES
	!#h::
		RegRead, HiddenFiles_Status, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden
		If HiddenFiles_Status = 2 
		RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 1
		Else 
		RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 2
		WinGetClass, eh_Class,A
		If (eh_Class = "#32770" OR A_OSVersion = "WIN_VISTA")
		send, {F5}
		Else PostMessage, 0x111, 28931,,, A
		Send, {F5}
		Return