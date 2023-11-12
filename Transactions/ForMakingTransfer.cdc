
import FungibleToken from 0x05
import IDGToken from 0x05

transaction(receiverAccount: Address, amount: UFix64) {

  
    let signerVault: &IDGToken.Vault
    let receiverVault: &IDGToken.Vault{FungibleToken.Receiver}

    prepare(acct: AuthAccount) {
     
        self.signerVault = acct.borrow<&IDGToken.Vault>(from: /storage/VaultStorage)
            ?? panic("No Vault in IDGToken's account")

        self.receiverVault = getAccount(receiverAccount)
            .getCapability(/public/Vault)
            .borrow<&IDGToken.Vault{FungibleToken.Receiver}>()
            ?? panic("Reciever has no vault")
    }

    execute {
        
        self.receiverVault.deposit(from: <-self.signerVault.withdraw(amount: amount))
        
        log("Coins has benn transferred successfully")
    }
}
