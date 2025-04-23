module 0x78fad9cc6e778755549e8c860328f06172e521f3db9be0ff756e8db94b44c3b3::global_admin {
    struct GlobalAdmin has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalAdmin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<GlobalAdmin>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

