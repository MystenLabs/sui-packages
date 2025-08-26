module 0xde4d1957dd0c31519878c0f88aec8c6a659a4123270ec636f05e9ee865993965::treasury_cap {
    struct TreasuryCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TreasuryCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<TreasuryCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

