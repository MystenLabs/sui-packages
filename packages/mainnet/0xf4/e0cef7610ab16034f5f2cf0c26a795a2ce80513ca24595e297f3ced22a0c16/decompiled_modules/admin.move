module 0xf4e0cef7610ab16034f5f2cf0c26a795a2ce80513ca24595e297f3ced22a0c16::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun destroy(arg0: AdminCap) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

