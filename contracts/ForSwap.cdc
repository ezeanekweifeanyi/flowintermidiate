
import FungibleToken from 0x05
import FlowToken from 0x05
import IDGToken from 0x05



pub contract Swap {

    
    pub var recentTimestampForSwap: UFix64
   
    pub var userrecentTimestampForSwaps: {Address: UFix64}

  
    pub fun swapTokens(signer: AuthAccount, swapAmount: UFix64) {

        let IDGTokenVault = signer.borrow<&IDGToken.Vault>(from: /storage/VaultStorage)
            ?? panic("unable to borrow IDGToken Vault")

        let flowVault = signer.borrow<&FlowToken.Vault>(from: /storage/FlowVault)
            ?? panic("unable to borrow Flow Token Vault")  

        let minterRef = signer.getCapability<&IDGToken.Minter>(/public/Minter).borrow()
            ?? panic("unable to borrow reference to IDGToken Minter")

        let autherVault = signer.getCapability<&FlowToken.Vault{FungibleToken.Balance, FungibleToken.Receiver, FungibleToken.Provider}>(/public/FlowVault).borrow()
            ?? panic("unable to borrow reference to Flow Token Vault")  

        let withdrawnAmount <- flowVault.withdraw(amount: swapAmount)
        
        autherVault.deposit(from: <-withdrawnAmount)

        let userAddress = signer.address
        
        self.recentTimestampForSwap = self.userrecentTimestampForSwaps[userAddress] ?? 1.0
   
        let currentTime = getCurrentBlock().timestamp

       
        let timeSinceLastSwap = currentTime - self.recentTimestampForSwap
        
        let mintedAmount = 2.0 * UFix64(timeSinceLastSwap)

       
        let newIDGTokenVault <- minterRef.mintToken(amount: mintedAmount)
      
        IDGTokenVault.deposit(from: <-newIDGTokenVault)
        
        self.userrecentTimestampForSwaps[userAddress] = timeSinceLastSwap
    }

    
    init() {
    
        self.recentTimestampForSwap = 1.0
  
        self.userrecentTimestampForSwaps = {0x01: 1.0}
    }
}
