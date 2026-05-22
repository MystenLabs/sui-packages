module 0xc77b320a443abbefd01833f2159a00f34b6ec6c141369a92fbd12a3fdb3183f8::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun sub() : address {
        @0x6cfb41025014bb58c20e8df80a71fa83b020f5acda7f9eee2a332b00a97ab330
    }

    // decompiled from Move bytecode v7
}

