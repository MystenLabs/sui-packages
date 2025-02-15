module 0x93006b08eb8743c87b2c1f206e02c34d9f6c337318e0bf111666a78f0196609a::global_admin {
    struct GlobalAdmin has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalAdmin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<GlobalAdmin>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

