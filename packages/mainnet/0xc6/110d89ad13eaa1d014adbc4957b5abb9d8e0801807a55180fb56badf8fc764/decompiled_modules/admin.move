module 0xc6110d89ad13eaa1d014adbc4957b5abb9d8e0801807a55180fb56badf8fc764::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public fun create_and_transfer(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

