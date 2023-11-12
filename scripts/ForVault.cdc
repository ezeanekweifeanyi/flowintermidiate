
import FungibleToken from 0x05
import IDGToken from 0x05

pub fun main(account: Address) {

   
    let publicVault = getAccount(account)
        .getCapability(/public/Vault)
        .borrow<&IDGToken.Vault{FungibleToken.Balance}>()
        ?? panic("Vault not found, setup might be incomplete")

    log("Vault setup verified successfully")
}
