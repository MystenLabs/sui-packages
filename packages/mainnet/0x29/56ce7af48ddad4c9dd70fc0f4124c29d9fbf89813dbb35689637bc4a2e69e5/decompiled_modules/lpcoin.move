module 0x2956ce7af48ddad4c9dd70fc0f4124c29d9fbf89813dbb35689637bc4a2e69e5::lpcoin {
    struct LPCOIN has key {
        id: 0x2::object::UID,
    }

    public fun new(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<LPCOIN>(arg0, 9, 0x1::string::utf8(b"CETUS-SUI Vault LPT"), 0x1::string::utf8(b"CETUS-SUI Haedal Vault LP Token"), 0x1::string::utf8(b"Haedal Vault LP Token, CETUS-SUI Pool"), 0x1::string::utf8(b"https://node1.irys.xyz/wDk5NmfNJXk2yT_ocfN3UuYtAltpTjGGr-MQzPNl9E0"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPCOIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<LPCOIN>>(0x2::coin_registry::finalize<LPCOIN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

