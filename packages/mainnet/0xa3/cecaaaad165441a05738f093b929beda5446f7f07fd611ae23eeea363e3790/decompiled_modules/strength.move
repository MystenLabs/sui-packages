module 0xa3cecaaaad165441a05738f093b929beda5446f7f07fd611ae23eeea363e3790::strength {
    struct Strength has store, key {
        id: 0x2::object::UID,
        strength: u64,
    }

    public entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Strength{
            id       : 0x2::object::new(arg0),
            strength : 3,
        };
        0x2::transfer::transfer<Strength>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

