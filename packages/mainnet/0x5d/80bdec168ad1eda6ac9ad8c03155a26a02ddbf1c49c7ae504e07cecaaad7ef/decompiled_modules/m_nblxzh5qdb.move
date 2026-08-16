module 0x5d80bdec168ad1eda6ac9ad8c03155a26a02ddbf1c49c7ae504e07cecaaad7ef::m_nblxzh5qdb {
    struct T_5kldtuzgei has store, key {
        id: 0x2::object::UID,
    }

    public entry fun f_plwbyu3ovd(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x33e5f12cea3d1384d9b12d95f888e4065bd3c572ca44340192eb2ab034b50d34, 0);
        let v0 = T_5kldtuzgei{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<T_5kldtuzgei>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

