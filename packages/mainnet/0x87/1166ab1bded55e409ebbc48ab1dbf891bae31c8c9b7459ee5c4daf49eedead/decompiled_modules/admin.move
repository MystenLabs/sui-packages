module 0xc33a96dc18fc894c191ea046cc170673ece2c6b3d28685f67e1d2b3027550591::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun a() : address {
        @0x646eba811906239f4f4ae8100ad224cc05959a3c1a771f8c7790b631a58e11fe
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

