module 0x59e85fe82f67b5bdb698a44d8bf9b00b08e6be83902cff423b1840a3bd1d25d3::authority {
    struct Authority has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Authority{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<Authority>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

