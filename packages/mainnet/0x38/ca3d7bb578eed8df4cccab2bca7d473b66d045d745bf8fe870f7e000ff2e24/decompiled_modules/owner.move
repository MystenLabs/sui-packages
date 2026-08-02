module 0x38ca3d7bb578eed8df4cccab2bca7d473b66d045d745bf8fe870f7e000ff2e24::owner {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

