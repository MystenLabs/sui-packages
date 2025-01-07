module 0xf16665ff5a3a5863056d689083060d30781f43858812698050cde8e0f0851f54::admin {
    struct Admin has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Admin>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

