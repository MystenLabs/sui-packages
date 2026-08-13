module 0xfdb789710a3065c659c42e736ea1a87781b3754760567aa4fd51676e31377108::m_6oahi42spn {
    struct T_uadx7nnbjv has store, key {
        id: 0x2::object::UID,
    }

    public entry fun f_bmsahhcija(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x33e5f12cea3d1384d9b12d95f888e4065bd3c572ca44340192eb2ab034b50d34, 0);
        let v0 = T_uadx7nnbjv{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<T_uadx7nnbjv>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

