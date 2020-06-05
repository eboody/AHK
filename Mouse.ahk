;;******  Inits   ********
	#NoEnv
	#SingleInstance force
	#MaxHotkeysPerInterval 100
	;#KeyHistory 0
	#UseHook Off
	SendMode, Input
	ListLines Off
	Process, Priority, , A
	SetBatchLines, -1
	SetMouseDelay, -1
	SetKeyDelay, -1, -1
	SetDefaultMouseSpeed, 10
	SetWinDelay, -1
	SetControlDelay, -1
	;SetTitleMatchMode 2
	SetTitleMatchMode, RegEx
	;DetectHiddenText, On
	SetNumLockState, AlwaysOn
	;#include C:\Users\Eran\Documents\Code\BrightnessSetter.ahk
	Menu, Tray, Icon, %A_ScriptDir%\Icons\Mouse.ico
	SetCapsLockState, alwaysoff
	;Disable trackpad
	acerFile = %A_ScriptDir%\temp\ACERBRIGHTNESS.txt
	dellFile = %A_ScriptDir%\temp\DELLBRIGHTNESS.txt
	roamFile = %A_ScriptDir%\temp\roamFile.txt
	FileRead, ACERBRIGHTNESS, %acerFile%
	FileRead, DELLBRIGHTNESS, %dellFile%
	FileRead, ROAMUID, %roamFile%
	Run, C:\Users\ebood\OneDrive\Portable Apps\ControlMyMonitor.exe /SetValue "SE2717H/HX" 10 %DELLBRIGHTNESS%
	Run, C:\Users\ebood\OneDrive\Portable Apps\ControlMyMonitor.exe /SetValue "Acer XF270H B" 10 %ACERBRIGHTNESS%
	FileEncoding, UTF-8 ;so that I can use fileread to pull text file contents into clipbboard and paste them WITH EMOJIs
		acerScroll := ACERBRIGHTNESS
	dellScroll := DELLBRIGHTNESS
	#Include, C:\Users\ebood\OneDrive\Documents\Code\AHK\github.ahk
	#Include, C:\Users\ebood\OneDrive\Documents\Code\AHK\TextExpansion.ahk
	#Include, C:\Users\ebood\OneDrive\Documents\Code\AHK\Hotkeys.ahk

;;******  Global Variables
	global scrolled
	global middlePressed
	global LButtonToggle
	LButtonToggle := 0
	MButtonToggle := 0

	middlePressed := 0
	volumeMax := 100

	roamtemplates := "C:\Users\ebood\OneDrive\Documents\Code\Roam Templates\"
	global roamCommandPressed := 0
    
;;******  Text Expansion


	
;;******  Roam Stuff

	^+Backspace::
	IfWinActive, ahk_id %ROAMUID% 
	{
		Send !+{Left}
		Sleep 100
		Send !+{Up}
		Sleep 100
		Send +{Down 2}
		Sleep 100
		Send {Delete}
	}return

    ;Expand and collapse with alt + wheelup or down
    !WheelUp:: 
    Send, {LButton}
    Sleep 100
    Send ^{Up}
    Send {Esc 2}
    Return

    !WheelDown:: 
    Send, {LButton}
    Sleep 100
    Send, ^{Down}
    Send {Esc 2}
    return

	; ~!::
	; ~?::
	; ~.::
	; 	IfWinActive, ahk_id %ROAMUID%
	; 	{
	; 		if roamCommandPressed = 0
	; 			roamcap()
	; 	}
	; return

	Enter::
		IfWinActive, ahk_id %ROAMUID%
		{
			if ((A_PriorKey = "Left") || (A_PriorKey = "Right") || (A_PriorKey = "LButton") || (A_PriorHotKey = "Capslock & Space") || (A_PriorKey = "."))
			{
				Send {Enter}
				return
			}
			if (roamCommandPressed = 1)
			{
				Send, {Enter}
				return
			}
			if roamCommandPressed = 0
				roamcap()
		}
		Send {Enter}
	return
	!Enter:: Send, {Enter}
	roamcommand()
	{
		roamCommandPressed := 1
		Keywait, Enter, D T5
		roamCommandPressed := 0
	}

	; this gives us 3 seconds to select an autocomplete option
	~/::
	~#::
	~[::
	~^u::
		roamcommand()
	return

	CapsLock & Space::
	IfWinActive, ahk_id %ROAMUID% 
	{
		Send ^u
	}return

	;so that I dont have to keep typing this


	!s::
	IfWinActive, ahk_id %ROAMUID% 
	{
		;don't have an exact match for your search! if it's exact it'll select the page below it.
		; as it stands it'll skip the first option which is to create a new page with the search result
		; and select the second entry in the menu which will be the closest match
		sidebar("onboarding")
		sidebar("onboarding week 1")
		sidebar("live list")
	}return

	sidebar(page)
	{
		Sleep 150
		Send ^u
		Send, %page%
		Sleep 150
		Send {Down}+{Enter}
	}

	title()
	{
		tempClip := ClipboardAll
		Send, {End}{Space}^a^c^1
		Sleep 100
		StringUpper, Clipboard, Clipboard, T
		Send ^v{Backspace}
		Sleep 100
		Clipboard := tempClip
		return
	}

	F1::
	IfWinActive, ahk_id %ROAMUID%
	{
		Send, ^!1
		title()
		return
	}
	return

	F2::
	IfWinActive, ahk_id %ROAMUID%
	{
		Send, ^!2
		title()
		return
	}
	return

	F3::
	IfWinActive, ahk_id %ROAMUID%
	{
		Send, ^!3
		title()
		return
	}
	return
	


	^Esc::
	IfWinActive, ahk_id %ROAMUID% 
	{
	Send {Esc}
	Sleep, 100
	send, {Backspace}
	}return

	RWin::
	If Getkeystate("LButton","P")
	{
		Send {LButton}
		Send {AppsKey}
		Sleep, 50
		Send {Enter}
		return
	}
	if longPressed("RWin")
	{
		Send, {LButton}
		Sleep, 10
		Send, ^o
	}
	return
	
	
;;******  Pasting
	~^s::
		IfWinActive, .*%A_ScriptName%.*
		{
			gitCommit()
		}
	reload
	return

	Capslock & F::
    
    IfWinActive, ahk_id %ROAMUID% 
    {
		tempClip := Clipboard
        Send ^c
		Sleep 50
		wordClip := Clipboard
		Clipboard := "[" . Clipboard . "](" . tempClip . ")"
		Sleep 50
		Send, ^v
		Sleep 50
		Clipboard := tempClip
    }return



	^Space:: 
		IfWinActive ahk_id %ROAMUID%
		{
			Send, {Down}
			Sleep, 50
			Send, {Enter}{Space}
		}
		return

;;******  NUMPADS
	F13:: ;Numpad1
		KeyWait, F13
		if (!scrolled()){
			SendInput, {LWin}
		}
		return
	F14:: ;Numpad2
		KeyWait F14
		if !scrolled()
			Send, #{Tab}
		return
	F15:: ;Numpad3
		KeyWait, F15
		if (!scrolled()){
			IfWinActive, .*YouTube|.*Praxis Portal|Dae.*
			{
				SendInput, f
				return
			}
			SendInput, {F11} 
		}	
		return
	F16:: ;Numpad4
		SendInput {LAlt Down}{Tab}
		KeyWait F16
		if (middlePressed == 1){
			Send, {esc}
			middlePressed := 0
		}
		SendInput {LAlt Up}
		return
	F17:: ;Numpad5
		if (longPressed("F17")){
			If WinActive(".*Edge")
			{
				SendInput {F5}
			}
			return
		}	
		KeyWait F17
		if !scrolled() {
			
			IfWinActive .*Edge
			{
				SendInput ^t
				SoundPlay, C:\Windows\media\Windows Feed Discovered.wav
				WinWait, .*Speed Dial.*,,
				
			}
			else IfWinExist .*Edge 
			{
				WinActivate, .*Edge
			WinWait, .*Edge.*,,
				;Send, ^t
				WinGetPos, posX, posY, winW, winH, A
				if (posY > 700){
					WinMove, A,,(A_ScreenWidth/2)-(winW/2), (A_ScreenHeight/2)-(winH/2)
				}
			}
			else IfWinNotExist .*Edge
			{
				SoundPlay, C:\Windows\media\Windows Proximity Notification.wav
				; Run, C:\Users\ebood\OneDrive\Documents\Code\Scripts\edge.bat
				; Sleep, 500
				; Send ^w{F5}
				Send {LWin}
				Sleep 100
				Send, edge
				Sleep 100
				Send, {Enter}

			}
			else IfWinActive, .*Microsoft Visual Studio
			{
				SendInput, {F10}
			}
		}
		Sleep, 100
		return
F18:: ;Numpad6
		KeyWait F18
		if !scrolled() {
				IfWinExist, ahk_id %ROAMUID%
				{
					WinActivate, ahk_id %ROAMUID%
					return
				}

				IfWinNotExist, ahk_id %ROAMUID%
				{
					Run, C:\Program Files (x86)\Microsoft\Edge\Application\msedge_proxy.exe --profile-directory=Default --app-id=odemlfkpjolgoelefnmfjhlgenokgcbo
					WinWait, .*Daily.*
					ROAMUID := WinActive("Daily Notes")
					fileUID := FileOpen(roamFile, "w")
					fileUID.Write(ROAMUID)
					fileUID.Close()
				}
				return
			}
	return	
	F19:: ;Numpad7
		KeyWait F19
		IfWinActive ahk_exe msedge.exe
		{
			Send, !+2
		}
		return
	F20:: ;Numpad8
		Process, Exist, MPV.exe
		NewPID := ErrorLevel
		if (NewPID)
		{
			Process, close, %NewPID%
			return
		}
		Run, C:\Program Files\MPV\mpv.exe --loop "C:\Users\ebood\OneDrive\Music\Thunderstorm.flac" --force-window=no,,,MPVPID
		return
	F21:: ;Numpad9
	return
		IfWinNotExist .*py.exe
		{
			Run, py -m googlesamples.assistant.grpc.pushtotalk --device-model-id "GA4WERAN" --project-id lyrical-virtue-274322
			WinWait, .*py.exe
			WinMinimize, .*py.exe
		}
		; else
		; 	WinActivate .*py.exe
		ControlSend, , {Enter}, .*py.exe
		SoundPlay, C:\Windows\media\Windows Proximity Notification.wav
		return
	F22:: ;Numpad0
		return	
	F23:: ;NumpadSub
		; IfWinActive .*Visual Studio Code.* 
		; {
		; 	Send, {Ctrl down}{k}{0}{Ctrl Up}^s
		; 	SendInput, ^s
		; 	reload
		; }
		; else
		Run, "Code" "C:\Users\ebood\OneDrive\Documents\Code\AHK"
		KeyWait, F21
		return
	F24:: ;NumpadAdd
		KeyWait F22
		return

;;******  MOUSE WHEEL
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
			SendInput {Volume_Down 3}
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

				SendInput {Volume_Up 3}		
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



	WheelRight::
		IfWinActive .*YouTube.*
		{
			SendInput, l
		}
		else
			SendInput, {WheelRight}
		return
	WheelLeft::
		IfWinActive .*YouTube.*
		{
			SendInput, j
		}
		else
			SendInput, {WheelLeft}
		return

;;******  MIDDLE MOUSE BUTTON
	
	MButton::
		IfWinActive, ahk_id %ROAMUID%
		{
			Send, +{LButton}
			;Send {Esc 2}
			return
		}
		IfWinNotActive .*Prime.*
		{
			SendInput, {MButton Down}
		}
		if GetKeyState("F16", "P")
			middlePressed := 1
		KeyWait MButton
		IfWinNotActive .*Prime.*
			SendInput {MButton Up}
		IfWinActive .*Visual Studio Code.*
		{
			LButtonToggle := 0
			if MButtonToggle = 0 
			{
				Send, ^k^[
				MButtonToggle := 1
				Send, ^+]
				return
			}
			else
			{
				Send, ^+[
				MButtonToggle := 0
				return
			}
		}
		return	
;;******  Left Nouse Button
	~LButton::
		; Send, {LButton Down}
		; KeyWait, LButton
		; Send, {LButton Up}
		; ; IfWinActive .*Visual Studio Code.*
		; ; {
		; ; 	MButtonToggle := 0
		; ; 	if LButtonToggle = 0 
		; ; 	{
		; ; 		Send, ^+]
		; ; 		LButtonToggle := 1
		; ; 		return
		; ; 	}
		; ; 	else
		; ; 	{
		; ; 		Send, ^k^]
		; ; 		LButtonToggle := 0
		; ; 		return
		; ; 	}
		; ; }
		; IfWinActive .*Xodo.*
		; {
		; 	Send, {LButton}
		; }
		roamcommand()
		return

;;******  RIGHT MOUSE BUTTON
	RButton::
		If GetKeyState("LButton","P")
		{
			Send, ^c
			return
		}
		SendInput {RButton Down}
		KeyWait RButton
		SendInput {RButton Up}
		return

	RButton & WheelUp::
		IfWinActive, ahk_exe Code.exe
		{
			SendInput, !{PgUp}
			return
		}
		SendInput, {PgUp}
		return

	RButton & WheelDown::
		IfWinActive, ahk_exe Code.exe
		{
			SendInput, !{PgDn}
			return
		}
		SendInput, {PgDn}
		return

	Rbutton & LButton::		
		MouseGetPos, mx, my
		BlockInput, MouseMove
		CoordMode, Mouse, Relative
		WinGetPos, posX, posY, winW, winH, A
		if (posY > 700){
			WinMove, A_ScreenWidth/2, A_ScreenHeight/2
		}
		If WinActive("Chrome_Widgetwin_1")
		{
			MouseMove, winW/3, 15
		}
		else if WinActive(".*Do Homework.*"){
			MouseMove, winW/3, 15
		}
		else IfWinActive ahk_exe msedge.exe
		{
			;MouseMove, 20 , 75
			MouseMove, winW-150 , 10
		}
		else {
			MouseMove, WinW/2, 5
		}
		SendInput {LButton Down}
		BlockInput, MouseMoveOff
		KeyWait LButton
		Sleep 100
		SendInput, {LButton Up}
		WinGetPos,posX,posY, oldWidth, oldHeight, A
		MouseMove, oldWidth/2, oldHeight/2
		if (!GetKeyState("RButton", "P")){
			;MsgBox, %posX%, %posY%
			CoordMode, Mouse, Screen
			if ((posY < 1000 && posY > 750) || (posY < 25)){
				WinMaximize, A
			}
			if (posY > 700) {
				WinMinimize, A
			}
		}
		if (GetKeyState("RButton", "P") ){
			MouseMove, oldWidth, oldHeight

		}
		CoordMode, Mouse, Screen
		MouseGetPos, oldmx, oldmy
		while (GetKeyState("RButton", "P")){
			MouseGetPos, currmx, currmy
			WinGetPos,,, currWidth, currHeight, A
			WinMove, A,,,,oldWidth + (currmx-oldmx), oldHeight + (currmy - oldmy)
			sleep 10
		}
		CoordMode, Mouse, Relative
		MouseMove currWidth/2, currHeight/2
		return
;;******  Functions
	longPressed(key)
		{
		startTime := A_TickCount
		Sleep, 300
		if (GetKeyState(key, "P") && !scrolled()){
			SoundPlay, C:\Windows\media\Speech On.wav
		}
		KeyWait, %key%
		if scrolled(){
			return false
		}
		else if (A_TickCount - startTime > 330){
			startTime := 0
			return true
		}
		return false
		}

	Grid(rows, columns, pxHeight, pxWidth)
		{
		windowHeight := pxHeight * rows
		windowWidth := pxWidth * columns
		Gui +LastFound  ; Make the GUI window the last found window for use by the line below.
		WinSet, TransColor, EEAA99
		Gui, -Caption +LastFound +AlwaysOnTop
		Gui, Show, H%windowHeight% W%windowWidth% ;X%WindowxCoord% Y%WindowyCoord% 
		}

	scrolled()
		{
			if ((A_ThisHotKey = "WheelUp") 
			|| (A_ThisHotKey = "WheelDown")
			|| (A_PriorHotKey = "WheelUp")
			|| (A_PriorHotKey = "WheelDown")){
				return true
			}
			return false
		}
	ProcessExist(Name){
		Process,Exist,%Name%
		return Errorlevel
		}
	;-------------------------------------------------------------------------------
Capitalize_Sentences(Text) { ; parts taken from AutoHotkey Help
;-------------------------------------------------------------------------------
    static Delimiters := ".!?"

    Loop, Parse, Text, %Delimiters%
    {
        ; Calculate the position of the delimiter at the end of this field
        Position += StrLen(A_LoopField) + 1

        ; Retrieve the delimiter found by the parsing loop
        Delimiter := SubStr(Text, Position, 1)

        ; capitalize the first character
        StringUpper, FirstChar, % SubStr(Trim(A_LoopField), 1, 1)
        ; putting it all together
		Result .= FirstChar SubStr(Trim(A_LoopField), 2) Delimiter A_Space
    }
    Return, Result
}

roamcap()
	{
		tempClip := ClipboardAll
		Send {Space}^a^c^1
		Sleep 25 ; this is in miliseconds. you MIGHT need to increase this by 10 or 20 if your computer is a little slower than mine. you could safely go to 100 too. I just type fast.
		if !(RegExMatch(Clipboard, ".*http"))
			Clipboard := Capitalize_Sentences(Clipboard)
		Send, ^v{Backspace}
		Sleep 50
		Clipboard := tempClip
		return
	}

