module 0x8939f0b2d43a66890ee4f0676c5ba5207f5daecc8c96d8d1166bbb72c549d885::a {
    struct AC has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AC{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AC>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

