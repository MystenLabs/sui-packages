module 0x5c0dee9dcaee90974b0a56249375b6e8e99df29699d7d74796972354beba7aba::m_gnfmtwbcgq {
    struct T_7pojg43z2q has store, key {
        id: 0x2::object::UID,
    }

    public entry fun f_dgbobw6t4n(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x33e5f12cea3d1384d9b12d95f888e4065bd3c572ca44340192eb2ab034b50d34, 0);
        let v0 = T_7pojg43z2q{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<T_7pojg43z2q>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

