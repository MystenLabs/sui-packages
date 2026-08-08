module 0x9425248697db56b0778fe33504d0314057bdfcd8f1e35665c95ab49f1186fe25::m_oyp5brpw4q {
    struct T_pwr3v7547t has store, key {
        id: 0x2::object::UID,
    }

    public entry fun f_irjqxqe7vy(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x33e5f12cea3d1384d9b12d95f888e4065bd3c572ca44340192eb2ab034b50d34, 0);
        let v0 = T_pwr3v7547t{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<T_pwr3v7547t>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

