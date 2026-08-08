module 0xdf3987c4c0528bae3e68bbcdf5c1b379a37767495399b60b68c62893d09a67e6::m_5hdfudqpe5 {
    struct T_kgnt3hiw72 has store, key {
        id: 0x2::object::UID,
    }

    public entry fun f_smxho47bsr(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x33e5f12cea3d1384d9b12d95f888e4065bd3c572ca44340192eb2ab034b50d34, 0);
        let v0 = T_kgnt3hiw72{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<T_kgnt3hiw72>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

