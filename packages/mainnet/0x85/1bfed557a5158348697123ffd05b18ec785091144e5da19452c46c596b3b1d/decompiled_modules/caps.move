module 0x851bfed557a5158348697123ffd05b18ec785091144e5da19452c46c596b3b1d::caps {
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

