;== == == ==  inits
 	#NoEnv
	#SingleInstance force
	#MaxHotkeysPerInterval 100
	;#KeyHistory 0
	#UseHook Off
	SetTitleMatchMode, RegEx
	SetNumLockState, AlwaysOn
	SetCapsLockState, alwaysoff

    SetCapsLockState, AlwaysOff

    FileEncoding, UTF-8 ;so that I can use fileread to pull text file contents into clipbboard and paste them WITH EMOJIs

    Menu, Tray, Icon, %A_ScriptDir%\Icons\roam.ico ;this is to have an icon in the tray

	FileRead, ROAMUID, %A_ScriptDir%\ROAMUID.txt ;this is to get the UID of the open roam window

;== == == ==  variables
	roamCommandPressed := 0

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
			if ((A_PriorKey = "Left") || (A_PriorKey = "Right") || (A_PriorKey = "LButton") || (A_PriorHotKey = "Capslock & Space") || (A_PriorKey = ".")) || (A_PriorKey = "Up") || (A_PriorKey = "Down") || (A_PriorKey = "Enter")
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
	~[::
	~^u::
		roamcommand()
	return

	CapsLock & Space::
	IfWinActive, ahk_id %ROAMUID% 
	{
		Send ^u
	}return



	!s::
	IfWinActive, ahk_id %ROAMUID% 
	{
		;don't have an exact match for your search! if it's exact it'll select the page below it.
		; as it stands it'll skip the first option which is to create a new page with the search result
		; and select the second entry in the menu which will be the closest match
		sidebar("hapday")
		sidebar("onboarding")
		sidebar("live list")
	}return

	sidebar(page)
	{
		Sleep 150
		Send ^u
		Send, %page%
		Sleep 200
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
		if !(RegExMatch(Clipboard, ".*http.*") || RegExMatch(Clipboard, ".*.com.*"))
			Clipboard := Capitalize_Sentences(Clipboard)
		Send, ^v{Backspace}
		Sleep 50
		Clipboard := tempClip
		return
	}
; ; == == == ==  launch the app
; F4::
;     Keywait F4
;     Ifwinexist, Ahk_id %ROAMUID%
;     {
;         Winactivate, Ahk_id %ROAMUID%
;         Return
;     }

;     Ifwinnotexist, Ahk_id %ROAMUID%
;     {
;         Run, C:\program Files (X86)\microsoft\edge\application\msedge_proxy.exe --Profile-directory=default --App-id=odemlfkpjolgoelefnmfjhlgenokgcbo
; 	Winwait, .*Daily.*
;         ROAMUID := Winactive("Daily Notes")
;         Fileuid := Fileopen("ROAMUID.txt", "W")
;         Fileuid.write(ROAMUID)
;         Fileuid.close()
;     }
;     Return

; ;== == == ==  text expansion
	
;     ;this ones worth mentioning
; 	:*:/Yout::
;     IfWinActive, ahk_id %ROAMUID% 
;     {
; 		tempClip := ClipboardAll
; 		Clipboard := "{{youtube: " . Clipboard . "}}"
; 		Sleep 25
; 		Send, ^v
; 		Sleep 25
; 		Clipboard := tempClip
;     }return

;     :*:/img::
;     IfWinActive, ahk_id %ROAMUID% 
;     {
; 		tempClip := ClipboardAll
; 		Clipboard := "![](" . Clipboard . ")"
; 		Sleep 25
; 		Send, ^v
; 		Sleep 25
; 		Clipboard := tempClip
;     }return

;     :?B0*:#::
; 		IfWinActive ahk_id %ROAMUID%
; 		{
; 			Send, [[]]
; 		}	
; 	return

; ;== == == ==  hotkeys
;     ;copy a URL, then highlight a word in roam and press caps+f or ctrl+k and it'll turn it into a link
; 	Capslock & F::
;     ^k::
;     IfWinActive, ahk_id %ROAMUID% 
;     {
; 		tempClip := Clipboard
;         Send ^c
; 		Sleep 50
; 		wordClip := Clipboard
; 		Clipboard := "[" . Clipboard . "](" . tempClip . ")"
; 		Sleep 50
; 		Send, ^v
; 		Sleep 50
; 		Clipboard := tempClip
;     }return

;     ;easier search bar
;     Capslock & Space::
; 	Ifwinactive, Ahk_id %ROAMUID% 
; 	{
; 		Send ^u
; 	}Return

;     ; easier autocomplete
;     ^Space:: 
;     IfWinActive ahk_id %ROAMUID%
;     {
;         Send, {Down}
;         Sleep, 50
;         Send, {Enter}{Space}
;     }
;     return


;     ; ctrl + Esc or Alt + Backspace deletes the block you're in
;     ^Esc::
; 	Ifwinactive, Ahk_id %ROAMUID% 
; 	{
; 	Send {Esc}
; 	Sleep, 100
; 	Send, {Backspace}
; 	}Return
    
;     ; easier headers
; 	title()
; 	{
; 		tempClip := ClipboardAll
; 		Send, {End}{Space}^a^c^1
; 		Sleep 50
; 		StringUpper, Clipboard, Clipboard, T
; 		Send ^+v
; 		Sleep 50
; 		Clipboard := tempClip
;         Send {Backspace}
; 		return
; 	}

;     ;H1
; 	F1::
; 	IfWinActive, ahk_id %ROAMUID%
; 	{
; 		Send, ^!1
; 		title()
; 		return
; 	}
; 	return
;     ;H2
; 	F2::
; 	IfWinActive, ahk_id %ROAMUID%
; 	{
; 		Send, ^!2
; 		title()
; 		return
; 	}
; 	return
;     ;H3
; 	F3::
; 	IfWinActive, ahk_id %ROAMUID%
; 	{
; 		Send, ^!3
; 		title()
; 		return
; 	}
; 	return

;     ; open certain things in the sidebar
;     !s::
; 	Ifwinactive, Ahk_id %ROAMUID% 
; 	{
; 		;Don't Have An Exact Match For Your Search! If It's Exact It'll Select The Page Below It.
; 		; As It Stands It'll Skip The First Option Which Is To Create A New Page With The Search Result
; 		; And Select The Second Entry In The Menu Which Will Be The Closest Match
; 		sidebar("vault")
; 		sidebar("live List")
; 		sidebar("project Management System")
; 		sidebar("project Sales")
; 		sidebar("sales Week 2")
; 		sidebar("learn About Cold Emails")
; 	}Return

; 	sidebar(page)
; 	{
; 		Sleep 150
; 		Send ^u
; 		Send, %Page%{Space}
; 		Sleep 150
; 		Send {Down}+{enter}
; 	}
    


;     ;== == == == *** Auto capitalize
; 	Enter::
; 		IfWinActive, ahk_id %ROAMUID%
; 		{
; 			if ((A_PriorKey = "Left") || (A_PriorKey = "Right") || (A_PriorKey = "LButton") || (A_PriorHotKey = "Capslock & Space") || (A_PriorKey = "."))
; 			{
; 				Send {Enter}
; 				return
; 			}
; 			if (roamCommandPressed = 1)
; 			{
; 				Send, {Enter}
; 				return
; 			}
; 			if roamCommandPressed = 0
; 				roamcap()
; 		}
; 		Send {Enter}
; 	return
; 	!Enter:: Send, {Enter}
; 	roamcommand()
; 	{
; 		roamCommandPressed := 1
; 		Keywait, Enter, D T5
; 		roamCommandPressed := 0
; 	}

; 	; this gives us 3 seconds to select an autocomplete option
; 	~/::
; 	~#::
; 	~[::
; 	~^u::
; 		roamcommand()
; 	return

;         Capitalize_sentences(text) { ; Parts Taken From Autohotkey Help
;             Static Delimiters := ".!?"

;             Loop, Parse, Text, %Delimiters%
;             {
;                 ; Calculate The Position Of The Delimiter At The End Of This Field
;                 Position += Strlen(a_loopfield) + 1

;                 ; Retrieve The Delimiter Found By The Parsing Loop
;                 Delimiter := Substr(text, Position, 1)

;                 ; Capitalize The First Character
;                 Stringupper, Firstchar, % Substr(trim(a_loopfield), 1, 1)
;                 ; Putting It All Together
;                 Result .= Firstchar Substr(trim(a_loopfield), 2) Delimiter A_space
;             }
;             Return, Result
;         }

;         roamcap()
;         {
;             tempClip := Clipboardall
;             Send {Space}^a^c^1 ;the ^1 is to avoid roam turning child blocks into document mode
;             Sleep 25 ; This Is In Miliseconds. You Might Need To Increase This By 10 Or 20 If Your Computer Is A Little Slower Than Mine. You Could Safely Go To 100 Too. I Just Type Fast.
;             If !(Regexmatch(clipboard, ".*Http")) ; ignore if it contains a URL
;                 Clipboard := Capitalize_sentences(clipboard)
;             Send, ^+v
;             Sleep 50
;             Clipboard := tempClip
;             Send {Backspace}
;             Return
;         }
;     ;== == == ==  MButton

;     Mbutton::
; 		Ifwinactive, Ahk_id %ROAMUID%
; 		{
; 			Send, +{Lbutton}
; 			Return
; 		}
;         Send {MButton Down}
;         KeyWait, MButton
;         Send {MButton Up}
;         return

;     ;Expand and collapse with alt + wheelup or down

;     !WheelUp:: 
;     Send, {LButton}
;     Sleep 100
;     Send ^{Up}
;     Send {Esc 2}
;     Return

;     !WheelDown:: 
;     Send, {LButton}
;     Sleep 100
;     Send, ^{Down}
;     Send {Esc 2}
;     return
