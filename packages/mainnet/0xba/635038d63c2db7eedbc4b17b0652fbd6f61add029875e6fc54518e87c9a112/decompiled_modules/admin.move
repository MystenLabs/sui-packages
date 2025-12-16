module 0xba635038d63c2db7eedbc4b17b0652fbd6f61add029875e6fc54518e87c9a112::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun create_and_transfer(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

