module 0xc422e44ac1e73f5e919a702bf96760c339ef6e60be24662c57bc9885ce98bc0a::registry {
    struct DiepsProfile has store, key {
        id: 0x2::object::UID,
        user: address,
        total_swaps: u64,
    }

    public fun register_profile(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DiepsProfile{
            id          : 0x2::object::new(arg0),
            user        : 0x2::tx_context::sender(arg0),
            total_swaps : 0,
        };
        0x2::transfer::transfer<DiepsProfile>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

