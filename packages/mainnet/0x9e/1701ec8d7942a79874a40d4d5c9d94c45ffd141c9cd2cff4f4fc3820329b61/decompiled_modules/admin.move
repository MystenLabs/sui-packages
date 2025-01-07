module 0x9e1701ec8d7942a79874a40d4d5c9d94c45ffd141c9cd2cff4f4fc3820329b61::admin {
    struct Admin has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Admin>(v0, @0x42dbd0fea6fefd7689d566287581724151b5327c08b76bdb9df108ca3b48d1d5);
    }

    // decompiled from Move bytecode v6
}

