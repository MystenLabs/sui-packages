module 0x860b1b7e891a69c34bbbfd95d4df984de38642ac3b5f18ba7b84f516055b5703::admin {
    struct Admin has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Admin{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Admin>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

