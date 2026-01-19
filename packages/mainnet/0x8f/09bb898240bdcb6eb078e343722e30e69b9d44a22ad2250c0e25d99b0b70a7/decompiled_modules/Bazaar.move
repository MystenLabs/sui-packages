module 0x8f09bb898240bdcb6eb078e343722e30e69b9d44a22ad2250c0e25d99b0b70a7::Bazaar {
    struct Vault has copy, drop {
        bazaar_id: u64,
        patarian_id: u64,
        phantom_addr: address,
        amount: u64,
        ferra: u64,
        cyra: u64,
        suistra: u64,
        proof: u64,
    }

    struct Hangar has copy, drop {
        bazaar_id: u64,
        patarian_id: u64,
        phantom_addr: address,
        amount: u64,
        group_no: u16,
        type_no: u16,
        count: u16,
        proof: u64,
    }

    struct Claimon has copy, drop {
        bazaar_id: u64,
        patarian_id: u64,
        phantom_addr: address,
        amount: u64,
        proof: u64,
    }

    public fun Deploy(arg0: u64, arg1: u64, arg2: u64, arg3: u16, arg4: u16, arg5: u16, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = Hangar{
            bazaar_id    : arg0,
            patarian_id  : arg1,
            phantom_addr : 0x2::tx_context::sender(arg7),
            amount       : arg2,
            group_no     : arg3,
            type_no      : arg4,
            count        : arg5,
            proof        : arg6,
        };
        0x2::event::emit<Hangar>(v0);
    }

    public fun Mint(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Claimon{
            bazaar_id    : arg0,
            patarian_id  : arg1,
            phantom_addr : 0x2::tx_context::sender(arg4),
            amount       : arg2,
            proof        : arg3,
        };
        0x2::event::emit<Claimon>(v0);
    }

    public fun Supply(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            bazaar_id    : arg0,
            patarian_id  : arg1,
            phantom_addr : 0x2::tx_context::sender(arg7),
            amount       : arg2,
            ferra        : arg3,
            cyra         : arg4,
            suistra      : arg5,
            proof        : arg6,
        };
        0x2::event::emit<Vault>(v0);
    }

    // decompiled from Move bytecode v6
}

