module 0xb99ce6968286da22744af161599bee5754637f95693875c2a1dfb898f27ced6e::meter {
    struct Permission has store, key {
        id: 0x2::object::UID,
        owner: address,
        spender: address,
        cap_usdc: u64,
        expiry_ms: u64,
    }

    public entry fun grant_permission(arg0: address, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Permission{
            id        : 0x2::object::new(arg3),
            owner     : 0x2::tx_context::sender(arg3),
            spender   : arg0,
            cap_usdc  : arg1,
            expiry_ms : arg2,
        };
        0x2::transfer::transfer<Permission>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

