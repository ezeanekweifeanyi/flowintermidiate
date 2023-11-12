
import FungibleToken from 0x05


pub contract IDGToken: FungibleToken {


    pub var vaults: [UInt64]


    pub var totalSupply: UFix64


    pub event TokensInitialized(initialSupply: UFix64)
    pub event TokensDeposited(amount: UFix64, to: Address?)
    pub event TokensWithdrawn(amount: UFix64, from: Address?)


    pub resource interface PublicVaultCollection {
    
        pub var balance: UFix64
       
        pub fun deposit(from: @FungibleToken.Vault)
        pub fun withdraw(amount: UFix64): @FungibleToken.Vault
        
        access(contract) fun adminWithdraw(amount: UFix64): @FungibleToken.Vault
    }

    pub resource Vault: FungibleToken.Provider, FungibleToken.Receiver, FungibleToken.Balance, PublicVaultCollection {
    
        pub var balance: UFix64

       
        init(balance: UFix64) {
            self.balance = balance
        }

        pub fun deposit(from: @FungibleToken.Vault) {
        
            let vault <- from as! @IDGToken.Vault
            
            emit TokensDeposited(amount: vault.balance, to: self.owner?.address)
            
            self.balance = self.balance + vault.balance
            vault.balance = 0.0
            
            destroy vault
        }


        pub fun withdraw(amount: UFix64): @FungibleToken.Vault {
            self.balance = self.balance - amount
                        
            emit TokensWithdrawn(amount: amount, from: self.owner?.address)
           
            return <-create Vault(balance: amount)
        }


        access(contract) fun adminWithdraw(amount: UFix64): @FungibleToken.Vault {
            self.balance = self.balance - amount
            
            return <-create Vault(balance: amount)
        }


        destroy() {
        
            IDGToken.totalSupply = IDGToken.totalSupply - self.balance
        }
    }


    pub resource Admin {

        pub fun adminGetCoin(senderVault: &Vault{PublicVaultCollection}, amount: UFix64): @FungibleToken.Vault {
            return <-senderVault.adminWithdraw(amount: amount)
        }
    }


    pub resource Minter {

        pub fun mintToken(amount: UFix64): @FungibleToken.Vault {
            IDGToken.totalSupply = IDGToken.totalSupply + amount
            
            return <-create Vault(balance: amount)
        }
    }

    init() {
  
        self.vaults = []
        self.totalSupply = 0.0
        
        emit TokensInitialized(initialSupply: self.totalSupply)
       
        self.account.save(<-create Admin(), to: /storage/AdminStorage)
        self.account.save(<-create Minter(), to: /storage/MinterStorage)
       
        self.account.link<&IDGToken.Minter>(/public/Minter, target: /storage/MinterStorage)
    }


    pub fun createEmptyVault(): @FungibleToken.Vault {
    
        let instance <- create Vault(balance: 0.0)
        
        self.vaults.append(instance.uuid)
        return <-instance
    }
}
