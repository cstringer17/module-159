# Dieses Powershell Skript importiert Einträge aus einer CSV Datei und erstellt daraus ein LDIF File
# Autor: David Schaad

#$csvFile = read-host "Bitte geben Sie die zu importierende Datei(.csv) inklusive Pfad an"
$csvFile = "C:\SCDA-Workspace\Desktop\Adressliste.csv"

#Einlesen CSV Datei
$importCSV = import-csv -Path $csvFile -Encoding Default -Delimiter ';'

#Speicherpfad und Dateiname für die LDIF Datei
$ldifFile = "C:\SCDA-Workspace\Desktop\Adressliste.ldif"

#Optionales Zählen der Datensätze
$Counter = 1

#Durchlaufen der Datensaetze der CSV
$object = ForEach ($user in $importCSV)
    {   
#Auslesen und Zuweisen der Attribute aus der CSV in eigene Variablen                
        $Name = $user.Name	
        $Vorname = $user.Vorname	
        $Adresse = $user.Adresse	
        $Hausnummer = $user.Hausnummer	
        $Land = $user.Land	
        $PLZ = $user.PLZ
        $Ort = $user.Ort

#Addieren der Strings
"#Entry Number: " + $Counter++
"dn: cn=" + $Vorname + " " + $Name + ",ou=kontakte,dc=schaad,dc=lan"
"cn: " + $Vorname + " " + $Name
"givenname: " + $Vorname
"l: " + $Ort
"objectClass: inetOrgPerson"
"objectClass: top"
"postalcode: " + $PLZ
"sn: " + $Name
"st: " + $Land
"street: " + $Adresse + " " + $Hausnummer
""

$object | Add-Content $ldifFile

}