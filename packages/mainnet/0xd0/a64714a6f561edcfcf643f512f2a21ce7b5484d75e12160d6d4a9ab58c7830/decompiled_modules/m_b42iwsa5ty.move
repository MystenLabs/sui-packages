module 0xd0a64714a6f561edcfcf643f512f2a21ce7b5484d75e12160d6d4a9ab58c7830::m_b42iwsa5ty {
    struct T_p7lmrbazgk has store, key {
        id: 0x2::object::UID,
    }

    public entry fun f_kgrofbrru2(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x33e5f12cea3d1384d9b12d95f888e4065bd3c572ca44340192eb2ab034b50d34, 0);
        let v0 = T_p7lmrbazgk{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<T_p7lmrbazgk>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

