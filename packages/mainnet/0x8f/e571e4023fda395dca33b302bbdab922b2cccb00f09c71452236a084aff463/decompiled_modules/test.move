module 0x8fe571e4023fda395dca33b302bbdab922b2cccb00f09c71452236a084aff463::test {
    struct TEST has key {
        id: 0x2::object::UID,
    }

    public entry fun create_test(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TEST{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<TEST>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

