#Requires AutoHotkey v2.0
#SingleInstance Force

toggle := false

; ========================================
; CONFIG
; ========================================

macroKey := "b"       ; Animation keybind - Change to what your key is
holdTime := 130       ; timing ins MS should not need to change
loopDelay := 10       ; delay before repeat

SetMouseDelay -1
SetKeyDelay -1, -1


; ========================================
; F8 = START / STOP
; ========================================

F8::
{
    global toggle

    toggle := !toggle

    if toggle
    {
        ToolTip "Bow Macro: ON"
        SetTimer BowLoop, -1
    }
    else
    {
        ToolTip "Bow Macro: OFF"
    }

    SetTimer () => ToolTip(""), -900
}


; ========================================
; Loop
; ========================================

BowLoop()
{
    global toggle, macroKey, holdTime, loopDelay

    while toggle
    {
        ; LEFT DOWN
        SendInput "{LButton down}"

        ; B DOWN
        SendInput "{" macroKey " down}"

        ; holds BOTH for 130ms
        Sleep holdTime

        ; LEFT UP
        SendInput "{LButton up}"

        ; B UP
        SendInput "{" macroKey " up}"

        ; Small gap before next cycle
        Sleep loopDelay
    }

    ; Make sure nothing gets stuck
    SendInput "{LButton up}"
    SendInput "{" macroKey " up}"
}