module 0x81420bd3231c91485250a92bdd22bc00e645ed2f3688461eec1dff3d78708d9e::global_admin {
    struct GlobalAdmin has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalAdmin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<GlobalAdmin>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

