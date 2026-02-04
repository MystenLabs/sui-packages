module 0xdc15a44ba004e2e1e27eaabd30468ee6d546699565d9c1272b2d70c140e3f04d::suimarket {
    struct FeeVault has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeVault{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<FeeVault>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

