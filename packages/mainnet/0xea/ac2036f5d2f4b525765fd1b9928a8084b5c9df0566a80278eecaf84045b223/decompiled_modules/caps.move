module 0x789c14ed19b6e46abc4694b0fef06590d25a91b317de85d99e0685a2d65c347c::caps {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MinterCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn_minter(arg0: MinterCap) {
        let MinterCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = MinterCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MinterCap>(v1, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

