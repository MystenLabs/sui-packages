module 0x136c3cf0b8c359ba714d6f26588672b98bdd8b14f9262b0c7b01cf8d971d4813::access {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun new(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg1)}
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

