#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


WheelDown:: ;
		if (GetKeyState("F13", "P")){
			SendInput ^#{Right}
		}
		else if (GetKeyState("F14", "P")){
			IfWinActive .*Visual Studio Code.*
			{
				SendInput ^{PgDn}
			}
			else SendInput ^{Tab}
		}
		else if (GetKeyState("F15", "P")){
			CoordMode, Mouse, Screen
			MouseGetPos, posX, posY
			if (posX > 0) & (acerScroll > 0)
			{
				acerScroll -= 20
				Run, C:\Users\ebood\OneDrive\Portable Apps\ControlMyMonitor.exe /ChangeValue "Acer XF270H B" 10 -20
				Progress, B zh0 fs100, %acerScroll%, , Brightness
				Sleep 350
				Progress, Off
				
				ACERBRIGHTNESS := FileOpen(acerFile, "w")
				ACERBRIGHTNESS.Write(acerScroll)
				ACERBRIGHTNESS.Close()
				return
			}
			else if (posX < 0) & (dellScroll > 0)
			{
				dellScroll -= 50
				Run, C:\Users\ebood\OneDrive\Portable Apps\ControlMyMonitor.exe /ChangeValue "SE2717H/HX" 10 -50
				Progress, B zh0 fs100, %dellScroll%, , Brightness
				WinMove, Brightness, ,-1100, 400
				Sleep 350
				Progress, Off
				DELLBRIGHTNESS := FileOpen(dellFile, "w")
				DELLBRIGHTNESS.Write(dellScroll)
				DELLBRIGHTNESS.Close()
				return
			}
		}
		else if (GetKeyState("F16", "P")){
			SendInput {Tab}
			return
		}
		else if (GetKeyState("MButton", "P")){
			SendInput {Volume_Down 1}
		}
		else if (GetKeyState("F17", "P")){
			IfWinActive, .*Microsoft Visual Studio
			{
				SendInput {F11}
			}
			else If WinActive("ahk_exe msedge.exe") | WinActive("ahk_class Chrome_WidgetWin_1")
			{
				SoundPlay, C:\Windows\media\Windows Startup.wav
				SendInput, ^w
			}
			else 
				SendInput, !{F4}
		}
		else if (GetKeyState("F18", "P")){
			IfWinActive .*YouTube|.*Praxis Portal.*|Dae Jang Geum.*
			{
				SendInput, l
			}
			else
			{
				SendInput ^{WheelDown}
				return
			}
		}
		else if (GetKeyState("F22","P")){
			Run DisplaySwitch.exe /Extend
		}
		else{
			SendInput {WheelDown}
		}
		Sleep, 20
		return
	WheelUp:: ;
		if (GetKeyState("F13", "P")){
			SendInput ^#{Left}
		}
		else if (GetKeyState("F14", "P")){
			IfWinActive .*Visual Studio Code.*
			{
				SendInput ^{PgUp}
			}
			else SendInput ^+{Tab}
		}
		else if (GetKeyState("F15", "P")){
			CoordMode, Mouse, Screen
			MouseGetPos, posX, posY
			;CoordMode, Tooltip, Screen
			if (posX > 0) & (acerScroll < 100)
			{
				acerScroll += 20
				Run, C:\Users\ebood\OneDrive\Portable Apps\ControlMyMonitor.exe /ChangeValue "Acer XF270H B" 10 20				
				Progress, B zh0 fs100, %acerScroll%, , Brightness
				Sleep 350
				Progress, Off
				ACERBRIGHTNESS := FileOpen(acerFile, "w")
				ACERBRIGHTNESS.Write(acerScroll)
				ACERBRIGHTNESS.Close()
				return
			}
			else if (posX < 0) & (dellScroll < 100){
				dellScroll += 50
				Run, C:\Users\ebood\OneDrive\Portable Apps\ControlMyMonitor.exe /ChangeValue "SE2717H/HX" 10 50				
				Progress, B zh0 fs100, %dellScroll%, , Brightness
				WinMove, Brightness, ,-1100, 400
				Sleep 350
				Progress, Off
				DELLBRIGHTNESS := FileOpen(dellFile, "w")
				DELLBRIGHTNESS.Write(dellScroll)
				DELLBRIGHTNESS.Close()
				return
			}
		}
		else if (GetKeyState("F16", "P")){
			SendInput +{Tab}
			return
		}
		else if (GetKeyState("MButton", "P")){

				SendInput {Volume_Up 1}		
		}
		else if (GetKeyState("F17", "P")){
			IfWinActive, .*Microsoft Visual Studio
			{
				SendInput {F11}
			}
			else If WinActive("ahk_exe msedge.exe") | WinActive("ahk_class Chrome_WidgetWin_1")
			{
				SoundPlay, C:\Windows\media\Windows Restore.wav
				SendInput, ^+t
			}
			Else
				SendInput, ^n
		}
		else if (GetKeyState("F18", "P")){
			IfWinActive .*YouTube|.*Praxis Portal.*|Dae Jang Geum.*
			{
				SendInput, j
			}
			else 
			{
				SendInput ^{WheelUp}
				return
			}
		}
		else if (GetKeyState("F22","P")){
			Run DisplaySwitch.exe /External

		}
		else if GetKeyState("LButton","P"){
			Send !v
		}
		else{
			SendInput {WheelUp}
		}
		Sleep, 20
		return