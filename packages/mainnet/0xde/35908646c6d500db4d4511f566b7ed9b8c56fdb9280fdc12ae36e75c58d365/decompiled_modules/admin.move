module 0xde35908646c6d500db4d4511f566b7ed9b8c56fdb9280fdc12ae36e75c58d365::admin {
    struct ADMIN has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: ADMIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

