IDGToken Cadence Contract

The "IDGToken" contract represents a sophisticated smart contract meticulously implemented on the Flow blockchain, functioning as an avant-garde fungible token utilizing the FungibleToken contract as its foundational framework. This contract orchestrates the orchestration of fungible tokens with an intricate collection of vaults designed for meticulous token storage. This README provides a comprehensive overview of the contract's intricate structure and multifaceted functionality.

Description

The "IDGToken" contract comprises the following intricate components:

 IDGToken Contract

The IDGToken contract, the paragon of virtuosity, stands as the paramount contract overseeing the orchestration of fungible tokens. An extension of the FungibleToken contract, it elegantly inherits its bedrock functionality.

- `vaults`: An array meticulously crafted for the storage of unique vault identifiers (UInt64).
- `totalSupply`: A pivotal variable symbolizing the total supply of tokens within the IDGToken contract.
- An array of meticulously defined events (TokensInitialized, TokensDeposited, and TokensWithdrawn) meticulously crafted to trace and document token operations.

PublicVaultCollection

PublicVaultCollection, an artful resource interface, meticulously delineates the functionality and properties of vaults within the contract. It encompasses functions of opulence, including balance, deposit, and withdrawal, intertwined with an administrative withdrawal function endowed with contract access.

 Vault

Vault, the epitome of resource sophistication, personifies an individual vault within the contract. Implementing interfaces of profound elegance such as FungibleToken.Provider, FungibleToken.Receiver, FungibleToken.Balance, and PublicVaultCollection, each vault possesses a balance (UFix64) that can be deposited, withdrawn, or administratively accessed.

- The `init` function, a magnum opus of initiation, breathes life into the vault's balance.
- The `deposit` function, akin to a grand gala, graciously allows the deposit of tokens from another vault.
- The `withdraw` function, a ballet of transactions, empowers the owner to gracefully withdraw tokens, birthing a new vault with the withdrawn amount.
- The `adminWithdraw` function, a symphony of administrative prowess, orchestrates the authoritative withdrawal of tokens from the vault.
- The `destroy` function, a crescendo of finality, permanently dismantles the vault and updates the total supply.

 Admin

Admin, the administrative maestro, stands as a resource of administrative virtuosity within the contract. It embraces the `adminGetCoin` function, a refined gesture, facilitating the withdrawal of IDGToken tokens from a sender's vault.

Minter

Minter, the virtuoso of minting, assumes the responsibility of elegantly minting new tokens within the contract. The `mintToken` function, an exquisite composition, breathes life into new tokens and gracefully updates the total supply.

 Initialization

In the contract's inaugural `init` function, a tapestry of resource initiation unfolds. Various contract resources and the total supply are unveiled with meticulous precision.

- An "Admin" resource and a "Minter" resource, paragons of virtuosity, are meticulously crafted and bestowed upon storage, with the "Minter" resource gracefully entwined with the contract's public capability.
- The `createEmptyVault` function, a masterstroke of emptiness creation, stands ready to craft an empty vault of sheer elegance with a balance of zero.

Access Control

Access control, a symphony of resource interfaces and types, permeates the contract's functionality. Public functions stand as gatekeepers, defining access control to specific operations of opulence.

 Getting Started

 Prerequisites

- Unrestricted access to the Flow blockchain development milieu.

Usage

Embark on the deployment of the "IDGToken" contract onto the Flow blockchain, employing the appropriate pantheon of development tools and environment.

Post-deployment, engage with the contract with the finesse of a maestro:

- Unleash the "Minter" resource, conducting the ballet of token creation and elevating the total supply.
- Invoke the `createEmptyVault` function, a sonnet of emptiness creation, bringing forth empty vaults of sheer sophistication.
- Engage in the deposit and withdrawal ballets, utilizing the `deposit` and `withdraw` functions to gracefully maneuver tokens within vaults.
- Harness the administrative functions within the "Admin" resource, executing certain operations with the poise of a virtuoso.

Prudently ascertain the establishment of the requisite Flow blockchain development environment to seamlessly deploy and interact with the transcendent elegance of Cadence contracts.

Author

Ifeanyi Ezeanekwe

 License

This magnum opus is licensed under the MIT License
