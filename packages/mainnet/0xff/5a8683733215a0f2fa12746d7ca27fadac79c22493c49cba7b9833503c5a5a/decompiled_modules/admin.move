module 0xff5a8683733215a0f2fa12746d7ca27fadac79c22493c49cba7b9833503c5a5a::admin {
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

