module 0x10d255d8912135c9cfdae85e37ab12c5a4d50ab52f0f822492da9fdf8b420006::treasury_cap {
    struct TreasuryCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TreasuryCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<TreasuryCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

