module 0x60c6ff4c6f5b4e201d2af46e40b549575dfe12fabb0b77da54860ca1c8a5ec8f::admin {
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

