module 0xf8aa580be0986e5aaf4d5184ce46667b990c07525759e16a8afcb9d20a46ef92::test {
    struct TEST has key {
        id: 0x2::object::UID,
    }

    public entry fun create_test(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TEST{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<TEST>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

