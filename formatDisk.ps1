
$disks=("BINARIOS","F","40"),
("DATA","G","100"),
("LOG","L","80"),
("TEMP-DATA","H","20"),
("TEMP-LOG","I","15") | ForEach-Object {[pscustomobject]@{label = $_[0]; letter = $_[1]; sizeingb = $_[2]}}

	for ($i=0;$i -lt $disks.count;$i++){
		$size=$disks[$i].sizeingb + "GB"
		$diskAtual=get-disk | Where-Object size -eq $size
		$diskLetter=$disks[$i].letter
		$diskLabel=$disks[$i].label
		
		
		if ($diskAtual.partitionstyle -eq "RAW"){
			Initialize-Disk -inputobject $diskAtual -PartitionStyle GPT -PassThru -WarningAction SilentlyContinue | New-Partition -DriveLetter $diskLetter -UseMaximumSize -WarningAction SilentlyContinue | Format-Volume -FileSystem NTFS -NewFileSystemLabel $diskLabel -AllocationUnitSize "65536"  -Confirm:$false -WarningAction SilentlyContinue > $null
		}
	}	