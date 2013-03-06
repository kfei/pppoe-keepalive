DIALNAME = "Hinet VDSL"
DIALUSER = "<username>@ip.hinet.net"
DIALPASS = "<password>"

Set WshShell = CreateObject("WScript.Shell")
RetCode = WshShell.Run("ping www.hinet.net", 0, true)
If RetCode <> 0 Then
    WshShell.Run "rasdial " & DIALNAME & " /DISCONNECT", 0, true
    WScript.Sleep(3000)
    WshShell.Run "rasdial " & DIALNAME & " " & DIALUSER & " " & DIALPASS, 0
End If
