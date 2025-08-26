module 0x8af66b05c0700217777f51f23763d397a15c16ebdca20c8ce1546f0889d138ca::treasury_cap {
    struct TreasuryCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TreasuryCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<TreasuryCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

