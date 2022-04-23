#Created by Joeya1ds 4/23/22
#taken from a script made I over a month ago (likely typos), apologies ahead of time
#You WILL NEED active directory modules installed on the computer the script is being run from

$filepath = "" #Enter file path here
$ADGROUP = "" #Enter AD group to be added

$total = Import-CSV $filepath | Select-Object -ExpandProperty "" #Enter specific CSV value/property to extract
$toutput = Write-Output $total
$toutput

For ($i = 0; $i -lt $toutput.Length; $i++){ #Iterating through device names on CSV
    $computer = Write-Output $toutput[$i] #Outputting current computer being processed
    ADD-ADGroupMember -identify $ADGROUP -members "$computer$"; #Adding computer to AD group
    $computer = "" #Resetting variable
}

Write-Output "Please Wait..." #Waiting is nescessary to update groups for computer
Start-Sleep 5

For ($i = 0; $i -lt $toutput.Length; $i++){ #Verifies the AD group was successfully added
    Write-Output = "-----"
    $computerPrint = Write-Output $toutput[$i]
    Write-Output "$computerPrint"
    Write-Output " "
    Get-ADPrincipalGroupMembership (Get-ADComputer $toutput[$i]).DistinguishedName | Select-Object name | ft -HideTableHeaders
}

Write-Output "-----"
Write-Output "If group(s) are properly listed for each computer, operation was successfully completed."
Write-Output "If it doesn't work, attempt to run the script again. Otherwise add the group(s) manually"
