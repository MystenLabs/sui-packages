module 0x262bff375b778278b38808faf281764c9b1a1a2a20c99283a1fa0b35d9ed55e4::yield_lego {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun deposit_usdsui<T0>(arg0: &AdminCap, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

