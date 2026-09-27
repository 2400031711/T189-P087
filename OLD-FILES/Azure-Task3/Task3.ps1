# Task 3 - Azure Resource Management

# 1. Verify Storage Account
$storageName = "klutask3storage8922"

Get-AzStorageAccount `
    -ResourceGroupName "MyResourceGroup" `
    -Name $storageName

# 2. Create Resource Group
New-AzResourceGroup `
    -Name "Task3-Move-RG" `
    -Location "centralindia"

# 3. Move Storage Account
Move-AzResource `
    -ResourceId "/subscriptions/9151fdea-ae5c-4c87-88f1-6aca550d3f35/resourceGroups/MyResourceGroup/providers/Microsoft.Storage/storageAccounts/klutask3storage8922" `
    -DestinationResourceGroupName "Task3-Move-RG"

# 4. Verify moved resource
Get-AzStorageAccount `
    -ResourceGroupName "Task3-Move-RG" `
    -Name $storageName

# 5. Create Resource Lock
New-AzResourceLock `
    -LockLevel CanNotDelete `
    -LockName "Task3-DeleteLock" `
    -ResourceName $storageName `
    -ResourceType "Microsoft.Storage/storageAccounts" `
    -ResourceGroupName "Task3-Move-RG"

# 6. Verify Resource Lock
Get-AzResourceLock `
    -ResourceGroupName "Task3-Move-RG"

# 7. Test Delete Operation
# Expected result: Conflict because of CanNotDelete lock
Remove-AzStorageAccount `
    -ResourceGroupName "Task3-Move-RG" `
    -Name $storageName
