"`nViolent Update Remover for Windows 7, 8, 8.1 by kill0rz (C) 2016" | Out-Host

$updatearray = 2919355,2952664,2976978,2977759,2990214,3021917,3022345,3035583,3044374,3045999,3050265,3065987,3068708,3075249,3075851,3080149,3112343,971033

"`nDeinstalliere Updates..." | Out-Host

ForEach($update in $updatearray) {
	" $update" | Out-Host
	cmd /c wusa /uninstall /kb:$update /quiet /norestart
}

"`nSuche Updates. Das kann mehrere Minuten dauern. Bitte Geduld ..." | Out-Host
$updates = ((New-Object -Com "Microsoft.Update.Session").CreateUpdateSearcher()).Search("IsInstalled=0 and Type='Software'")

"`nVerstecke Updates, damit sie nicht wieder installiert werden:" | Out-Host
ForEach($update in $updatearray) {
	$updates.Updates | %{
		If($_.Title -like "*$update*"){
			$_.IsHidden = $true
			write-host "$($_.Title) erfolgreich versteckt!"
		}
	}
}

"`nErfolgreich beendet!" | Out-Host
