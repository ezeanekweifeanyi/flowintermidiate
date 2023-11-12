
import FungibleToken from 0x05
import IDGToken from 0x05


transaction() {

  
    let userVault: &IDGToken.Vault{FungibleToken.Balance, FungibleToken.Provider, FungibleToken.Receiver, IDGToken.PublicVaultCollection}?
    let account: AuthAccount

    prepare(acct: AuthAccount) {

       
        self.userVault = acct.getCapability(/public/Vault)
            .borrow<&IDGToken.Vault{FungibleToken.Balance, FungibleToken.Provider, FungibleToken.Receiver, IDGToken.PublicVaultCollection}>()

        self.account = acct
    }

    execute {
 
        if self.userVault == nil {
       
            let emptyVault <- IDGToken.createEmptyVault()
         
            self.account.save(<-emptyVault, to: /storage/VaultStorage)
      
            self.account.link<&IDGToken.Vault{FungibleToken.Balance, FungibleToken.Provider, FungibleToken.Receiver, IDGToken.PublicVaultCollection}>(/public/Vault, target: /storage/VaultStorage)
          
            log("Empty vault created and linked")
        } else {
       
            log("Vault already exists and is properly linked")
        }
    }
}
