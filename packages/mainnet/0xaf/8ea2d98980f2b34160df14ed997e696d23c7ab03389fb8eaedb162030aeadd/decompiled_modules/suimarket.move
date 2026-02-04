module 0xaf8ea2d98980f2b34160df14ed997e696d23c7ab03389fb8eaedb162030aeadd::suimarket {
    struct FeeVault has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeVault{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<FeeVault>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

