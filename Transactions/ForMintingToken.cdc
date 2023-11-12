
import FungibleToken from 0x05
import IDGToken from 0x05

transaction(receiver: Address, amount: UFix64) {

    prepare(signer: AuthAccount) {
      
        let minter = signer.borrow<&IDGToken.Minter>(from: /storage/MinterStorage)
            ?? panic("Only IDGToken Owner has acess")
        
   
        let receiverVault = getAccount(receiver)
            .getCapability<&IDGToken.Vault{FungibleToken.Receiver}>(/public/Vault)
            .borrow()
            ?? panic("Check your Vault status")
        
       
        let mintedTokens <- minter.mintToken(amount: amount)

        
        receiverVault.deposit(from: <-mintedTokens)
    }

    execute {
  
        log("Coins minted and deposited successfully")
     
        log(amount.toString().concat(" Coins sucessfully minted"))
    }
}
