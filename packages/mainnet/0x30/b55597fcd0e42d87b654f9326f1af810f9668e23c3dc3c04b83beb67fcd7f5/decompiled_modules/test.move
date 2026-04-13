module 0x30b55597fcd0e42d87b654f9326f1af810f9668e23c3dc3c04b83beb67fcd7f5::test {
    struct Presale<phantom T0> has store, key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::ascii::String,
        status: u8,
    }

    public entry fun create_presale<T0>(arg0: 0x1::ascii::String, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v7
}

