module 0x42525ee7639332b7b8fc6f740f62ba3cbb0f130ad1f963d9d694ad304f460fa9::lpcoin {
    struct LPCOIN has key {
        id: 0x2::object::UID,
    }

    public fun new(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<LPCOIN>(arg0, 6, 0x1::string::utf8(b"WAL-USDC Vault LPT"), 0x1::string::utf8(b"WAL-USDC Haedal Vault LP Token"), 0x1::string::utf8(b"Haedal Vault LP Token, WAL-USDC Pool"), 0x1::string::utf8(b"https://node1.irys.xyz/Mg3l6CyMGJXkJ1Gx919T6otWXSZ95RLAufsk6M_fljA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPCOIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<LPCOIN>>(0x2::coin_registry::finalize<LPCOIN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

