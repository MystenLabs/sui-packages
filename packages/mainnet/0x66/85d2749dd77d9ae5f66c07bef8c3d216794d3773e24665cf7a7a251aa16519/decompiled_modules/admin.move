module 0x6685d2749dd77d9ae5f66c07bef8c3d216794d3773e24665cf7a7a251aa16519::admin {
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

