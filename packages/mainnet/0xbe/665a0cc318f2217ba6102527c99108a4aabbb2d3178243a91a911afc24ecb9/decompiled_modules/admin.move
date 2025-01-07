module 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun new_mint_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MintCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<MintCap>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

