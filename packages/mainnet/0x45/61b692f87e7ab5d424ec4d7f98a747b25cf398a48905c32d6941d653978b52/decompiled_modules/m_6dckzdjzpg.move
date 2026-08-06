module 0x4561b692f87e7ab5d424ec4d7f98a747b25cf398a48905c32d6941d653978b52::m_6dckzdjzpg {
    struct T_a7d4rfuwsp has store, key {
        id: 0x2::object::UID,
    }

    public entry fun f_wwzljclfnu(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x33e5f12cea3d1384d9b12d95f888e4065bd3c572ca44340192eb2ab034b50d34, 0);
        let v0 = T_a7d4rfuwsp{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<T_a7d4rfuwsp>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

