
$csv = Import-Csv G:\_Work\Gibm\Module\M159\scripts\migration\lehrer\lehrer.csv
$ldifFile = "G:\_Work\Gibm\Module\M159\scripts\migration\lehrer\lehrer.ldif"
$uidvar = 1000

$object = ForEach ($user in $csv)
    {   

"dn: cn="+ $user.Beschreibung +",ou=LP,dc=gerzenstein,dc=com `n"+
"changetype: add
objectClass: inetOrgPerson
objectClass: organizationalPerson
objectClass: posixAccount
objectClass: top
loginShell: /bin/bash
gidnumber: 509
cn: "+ $user.Beschreibung +"
gn: "+  $user.Name.Substring(0, $user.Name.IndexOf(".")) +"
sn: "+$user.Nachname+"
uid: "+ $user.Name +"
homeDirectory: /home/users/"+ $user.Name+"
mail: "+ $user.Name +"@gertzenstein.local
uidnumber: "+ $uidvar++ +"
userPassword: leer
"
}

$object | Add-Content $ldifFile