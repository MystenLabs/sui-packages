module 0xacaf0b5d5f8a03cc37f043608f92ca56f1753b4903c9f487f43fd4af97721c9::lpcoin {
    struct LPCOIN has key {
        id: 0x2::object::UID,
    }

    public fun new(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<LPCOIN>(arg0, 9, 0x1::string::utf8(b"CETUS-SUI Vault LPT"), 0x1::string::utf8(b"CETUS-SUI Haedal Vault LP Token"), 0x1::string::utf8(b"Haedal Vault LP Token, CETUS-SUI Pool"), 0x1::string::utf8(b"https://node1.irys.xyz/wDk5NmfNJXk2yT_ocfN3UuYtAltpTjGGr-MQzPNl9E0"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPCOIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<LPCOIN>>(0x2::coin_registry::finalize<LPCOIN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

