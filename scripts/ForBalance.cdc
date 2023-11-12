
import FungibleToken from 0x05
import IDGToken from 0x05

pub fun main(account: Address) {

   
    let publicVault: &IDGToken.Vault{FungibleToken.Balance, FungibleToken.Receiver, IDGToken.PublicVaultCollection}? =
        getAccount(account).getCapability(/public/Vault)
            .borrow<&IDGToken.Vault{FungibleToken.Balance, FungibleToken.Receiver, IDGToken.PublicVaultCollection}>()

    if (publicVault == nil) {
        

     
        let newVault <- IDGToken.createEmptyVault()
        getAuthAccount(account).save(<-newVault, to: /storage/VaultStorage)
        
        getAuthAccount(account).link<&IDGToken.Vault{FungibleToken.Balance, FungibleToken.Receiver, IDGToken.PublicVaultCollection}>(
            /public/Vault,
            target: /storage/VaultStorage
        )
       
        log("created Empty vault")
        
       
        let retrievedVault: &IDGToken.Vault{FungibleToken.Balance}? =
            getAccount(account).getCapability(/public/Vault)
                .borrow<&IDGToken.Vault{FungibleToken.Balance}>()
        log(retrievedVault?.balance)
    } else {


        log("Vault already exists")
        
    
        let checkVault: &IDGToken.Vault{FungibleToken.Balance, FungibleToken.Receiver, IDGToken.PublicVaultCollection} =
            getAccount(account).getCapability(/public/Vault)
                .borrow<&IDGToken.Vault{FungibleToken.Balance, FungibleToken.Receiver, IDGToken.PublicVaultCollection}>()
                ?? panic("found no Vault capability")
        
       
        if IDGToken.vaults.contains(checkVault.uuid) {
            log(publicVault?.balance)
            log("This is a IDGToken vault")
        } else {
            log("This is not a IDGToken vault")
        }
    }
}
