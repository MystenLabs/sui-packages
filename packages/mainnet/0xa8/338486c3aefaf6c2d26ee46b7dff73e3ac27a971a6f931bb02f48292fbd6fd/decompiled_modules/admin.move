module 0xa8338486c3aefaf6c2d26ee46b7dff73e3ac27a971a6f931bb02f48292fbd6fd::admin {
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

