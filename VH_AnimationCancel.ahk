# Animation Cancel for Valheim
# Works best with FinewoodBow
# Setup with "B" as bound key
# F8 → toggle macro
# PgUp / PgDn → adjust click hold
# F9/F10 → tweak how long before B fires
# Home/End → quick reset
toggle := false
clickHold := 10   ; how long to hold left-click (ms)
bDelay   := 8     ; delay AFTER click-up BEFORE sending B (ms)

; faster input handling
SetMouseDelay -1
SetKeyDelay  -1, -1

; ---- Hotkeys ----
; F8 = toggle macro
F8:: {
    global toggle
    toggle := !toggle
    if toggle
        SetTimer BowLoop, 10
    else
        SetTimer BowLoop, 0
}

; PageUp/PageDown: adjust left-click hold
PgUp::AdjustClickHold(1)
PgDn::AdjustClickHold(-1)

; F9/F10: adjust B offset
F9::AdjustBDelay(1)
F10::AdjustBDelay(-1)

; Home/End: quick resets
Home::ResetClickHold()
End::ResetBDelay()

; ---- Functions ----
AdjustClickHold(step) {
    global clickHold
    clickHold := Max(1, clickHold + step)
    ShowStatus()
}

AdjustBDelay(step) {
    global bDelay
    bDelay := Max(0, bDelay + step)
    ShowStatus()
}

ResetClickHold() {
    global clickHold
    clickHold := 10
    ShowStatus()
}

ResetBDelay() {
    global bDelay
    bDelay := 8
    ShowStatus()
}

BowLoop() {
    global clickHold, bDelay
    ; Left click with adjustable hold
    Click "down left"
    Sleep clickHold
    Click "up left"

    ; Tiny offset before sending B
    Sleep bDelay
    SendInput "{b down}"
    Sleep 10
    SendInput "{b up}"

    Sleep 15  ; tiny spacer before next iteration
}

ShowStatus() {
    global clickHold, bDelay
    ToolTip "ClickHold: " clickHold " ms | B Delay: " bDelay " ms"
    SetTimer () => ToolTip(""), -900
}
