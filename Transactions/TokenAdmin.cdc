
import FungibleToken from 0x05
import FlowToken from 0x05
import IDGToken from 0x05

transaction(senderAccount: Address, amount: UFix64) {

    
    let senderVault: &IDGToken.Vault{IDGToken.PublicVaultCollection}
    let signerVault: &IDGToken.Vault
    let senderFlowVault: &FlowToken.Vault{FungibleToken.Balance, FungibleToken.Receiver, FungibleToken.Provider}
    let adminResource: &IDGToken.Admin
    let flowMinter: &FlowToken.Minter

    prepare(acct: AuthAccount) {
   
        self.adminResource = acct.borrow<&IDGToken.Admin>(from: /storage/AdminStorage)
            ?? panic("No Admin Resource")

        self.signerVault = acct.borrow<&IDGToken.Vault>(from: /storage/VaultStorage)
            ?? panic("No Vault in IDGToken account")

        self.senderVault = getAccount(senderAccount)
            .getCapability(/public/Vault)
            .borrow<&IDGToken.Vault{IDGToken.PublicVaultCollection}>()
            ?? panic("Vault not found in senderAccount")

        self.senderFlowVault = getAccount(senderAccount)
            .getCapability(/public/FlowVault)
            .borrow<&FlowToken.Vault{FungibleToken.Balance, FungibleToken.Receiver, FungibleToken.Provider }>()
            ?? panic("Flow vault not found in senderAccount")

        self.flowMinter = acct.borrow<&FlowToken.Minter>(from: /storage/FlowMinter)
            ?? panic("No Minter")
    }

    execute {
      
        let newVault <- self.adminResource.adminGetCoin(senderVault: self.senderVault, amount: amount)        
        log(newVault.balance)
        
        
        self.signerVault.deposit(from: <-newVault)

      
        let newFlowVault <- self.flowMinter.mintTokens(amount: amount)

    
    
        self.senderFlowVault.deposit(from: <-newFlowVault)
        log("Done!!!")
    }
}
