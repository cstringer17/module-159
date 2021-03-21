
$csv = Import-Csv G:\_Work\Gibm\Module\M159\scripts\migration\Verwaltung\Verwaltung.csv
$ldifFile = "G:\_Work\Gibm\Module\M159\scripts\migration\verwaltung\verwaltung.ldif"
$uidvar = 1150

$object = ForEach ($user in $csv)
    {   

"dn: cn="+ $user.Nachname +",ou=Verwaltung,dc=gerzenstein,dc=com `n"+
"changetype: add
objectClass: inetOrgPerson
objectClass: organizationalPerson
objectClass: posixAccount
objectClass: top
loginShell: /bin/bash
gidnumber: 509
cn: "+ $user.Nachname +"
gn: "+  $user.Name.Substring(0, $user.Name.IndexOf(".")) +"
sn: "+$user.Nachname+"
uid: "+ $user.Name +"
homeDirectory: /home/users/"+$user.Nachname+"
mail: "+ $user.Name +"@gertzenstein.local
uidnumber: "+ $uidvar++ +"
userPassword: leer
"
}

$object | Add-Content $ldifFile