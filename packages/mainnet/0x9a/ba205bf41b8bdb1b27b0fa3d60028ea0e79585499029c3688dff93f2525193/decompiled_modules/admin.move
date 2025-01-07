module 0x9aba205bf41b8bdb1b27b0fa3d60028ea0e79585499029c3688dff93f2525193::admin {
    struct Admin has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Admin>(v0, @0x42dbd0fea6fefd7689d566287581724151b5327c08b76bdb9df108ca3b48d1d5);
    }

    // decompiled from Move bytecode v6
}

