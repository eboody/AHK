:*:/weeklygoal::
    Date += 1, Days
    FormatTime, nDate, %Date%, dd
    suffix := f(nDate)
    dateLink = [[%A_MMMM% %suffix% %A_YYYY%]]
    Clipboard := dateLink
    Send, **Week:** ^v to 
    Date += 6, Days
    FormatTime, nDate, %Date%, dd
    suffix := f(nDate)
    dateLink = [[%A_MMMM% %suffix% %A_YYYY%]]
    Clipboard := dateLink
    Send, ^v{Enter}{Tab}
    sleep 50
    Clipboard := "#linebreak"
    Send ^v{Enter}
    i := 0
    sleep 25
    Date :=
while (i<7){
    
    FormatTime, nDate, %Date%, dd
    suffix := f(nDate)
    i++
    dateLink = [[%A_MMMM% %suffix% %A_YYYY%]]
    Clipboard := dateLink
    Send, ^v{Enter}
    sleep 75
    Date += 1, Days
}
send {BackSpace}
return


f(d) {
static SUFFIX := ["st", "nd", "rd"]

if (Mod(d, 100) ~= "1[1-3]")
    return d "th"

if ((lastDigit := Mod(d, 10)) ~= "[1-3]")
    return d SUFFIX[lastDigit]
else
    return d "th"
}