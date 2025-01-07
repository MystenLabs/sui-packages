module 0x1c8eec59a42b5959fa9065ebdf6068281c183233d4cbcea7b937440299911c8::credenza_contract_metadata {
    struct CredenzaContractMetadata<phantom T0> has store, key {
        id: 0x2::object::UID,
        deployer: address,
        treasury_cap: address,
        metadata: address,
        sell_config: address,
    }

    public fun create_credenza_metadata<T0>(arg0: address, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : CredenzaContractMetadata<T0> {
        CredenzaContractMetadata<T0>{
            id           : 0x2::object::new(arg3),
            deployer     : 0x2::tx_context::sender(arg3),
            treasury_cap : arg0,
            metadata     : arg1,
            sell_config  : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

