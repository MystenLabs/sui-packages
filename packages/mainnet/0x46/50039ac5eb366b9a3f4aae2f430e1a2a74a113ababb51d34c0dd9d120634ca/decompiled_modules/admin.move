module 0x4650039ac5eb366b9a3f4aae2f430e1a2a74a113ababb51d34c0dd9d120634ca::admin {
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

