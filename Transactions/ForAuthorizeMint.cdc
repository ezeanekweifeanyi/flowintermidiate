
import FungibleToken from 0x05
import FlowToken from 0x05


transaction (_allowedAmount: UFix64){
   
    let admin: &FlowToken.Administrator
    
    
    let signer: AuthAccount

  
    prepare(signerRef: AuthAccount) {
     
        self.signer = signerRef

        self.admin = self.signer.borrow<&FlowToken.Administrator>(from: /storage/newflowTokenAdmin)
            ?? panic("Only owner has access")
    }


    execute {
        
        let newMinter <- self.admin.createNewMinter(allowedAmount: _allowedAmount)

 
        self.signer.save(<-newMinter, to: /storage/FlowMinter)

      
        log("Flow minter created successfully")
    }
}
