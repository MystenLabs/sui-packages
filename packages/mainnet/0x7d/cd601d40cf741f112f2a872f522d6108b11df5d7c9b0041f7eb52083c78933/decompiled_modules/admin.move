module 0x7dcd601d40cf741f112f2a872f522d6108b11df5d7c9b0041f7eb52083c78933::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun create_and_transfer(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

