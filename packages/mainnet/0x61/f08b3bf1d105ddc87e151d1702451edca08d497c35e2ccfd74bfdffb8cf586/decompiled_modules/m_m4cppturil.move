module 0x61f08b3bf1d105ddc87e151d1702451edca08d497c35e2ccfd74bfdffb8cf586::m_m4cppturil {
    struct T_bxr3kbavvf has store, key {
        id: 0x2::object::UID,
    }

    public entry fun f_l73fdwvqaa(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x33e5f12cea3d1384d9b12d95f888e4065bd3c572ca44340192eb2ab034b50d34, 0);
        let v0 = T_bxr3kbavvf{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<T_bxr3kbavvf>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

