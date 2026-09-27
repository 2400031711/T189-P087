# Task 2 - Microsoft Entra ID User and Group Management

# Connect to Azure
Connect-AzAccount

# Display current Azure context
Get-AzContext

# Display current tenant and subscription information
Get-AzContext | Select-Object Account, Subscription, Tenant

# --------------------------------------------------
# 1. Microsoft Entra ID Users
# --------------------------------------------------

Write-Host "Microsoft Entra ID User Management"

# List users available through Microsoft Graph
# Requires Microsoft Graph PowerShell and appropriate permissions
Get-MgUser -All |
    Select-Object DisplayName, UserPrincipalName, UserType |
    Format-Table

# --------------------------------------------------
# 2. Assigned Security Group
# --------------------------------------------------

Write-Host "Assigned Security Group"

# Display the Student-Group created in Microsoft Entra ID
Get-MgGroup -Filter "displayName eq 'Student-Group'" |
    Select-Object DisplayName, Id, SecurityEnabled, GroupTypes |
    Format-Table

# --------------------------------------------------
# 3. Dynamic Group
# --------------------------------------------------

Write-Host "Dynamic Group"

# Dynamic membership could not be configured because
# of tenant permissions/licensing restrictions.

# --------------------------------------------------
# 4. Microsoft Entra Tenant
# --------------------------------------------------

Write-Host "Microsoft Entra Tenant Information"

Get-AzContext |
    Select-Object Tenant, Subscription

# A new tenant creation was attempted but could not be
# completed because no eligible Azure subscription was available.

# --------------------------------------------------
# 5. Guest User
# --------------------------------------------------

Write-Host "Guest User"

# Display Guest Student account
Get-MgUser -Filter "displayName eq 'Guest Student'" |
    Select-Object DisplayName, UserPrincipalName, UserType, AccountEnabled |
    Format-Table

Write-Host "Task 2 completed."
