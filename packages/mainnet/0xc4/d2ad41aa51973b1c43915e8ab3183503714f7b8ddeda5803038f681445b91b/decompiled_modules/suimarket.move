module 0xc4d2ad41aa51973b1c43915e8ab3183503714f7b8ddeda5803038f681445b91b::suimarket {
    struct FeeVault has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeVault{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<FeeVault>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

