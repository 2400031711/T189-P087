# Task 3 - Azure Resource Management

## 1. Deploy Resource
A Storage Account named `klutask3storage8922` was created in the existing Resource Group `MyResourceGroup`.

- Location: Central India
- SKU: Standard_LRS
- Kind: StorageV2
- Provisioning State: Succeeded

## 2. Move Resource Between Resource Groups
A new Resource Group `Task3-Move-RG` was created in Central India.

The Storage Account was moved from:

`MyResourceGroup` → `Task3-Move-RG`

The moved resource was verified successfully.

## 3. Implement and Test Resource Lock
A `CanNotDelete` resource lock named `Task3-DeleteLock` was created on the Storage Account.

A delete operation was tested and returned:

`Conflict`

This confirmed that the Resource Lock successfully prevented deletion.

The Storage Account was verified again and remained in `Succeeded` state.

## Result
The Azure resource was successfully deployed, moved between Resource Groups, protected using a Resource Lock, and the lock was tested successfully.
