module 0xfc41d47d29514b8cedc9805819b9a6ebc7da63096c12f007a67f3686516aaa90::new_mod {
    struct Test has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Test{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Test>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

