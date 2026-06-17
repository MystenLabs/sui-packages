module 0x72de3403e484cf7f60b46a79617b9e6f326ec8b9eeecb206f6adbc2bb284b7ef::lpcoin {
    struct LPCOIN has key {
        id: 0x2::object::UID,
    }

    public fun new(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<LPCOIN>(arg0, 9, 0x1::string::utf8(b"DEEP-SUI Vault LPT"), 0x1::string::utf8(b"DEEP-SUI Haedal Vault LP Token"), 0x1::string::utf8(b"Haedal Vault LP Token, DEEP-SUI Pool"), 0x1::string::utf8(b"https://node1.irys.xyz/NVpcEHcDm71AOiNdu5BjfZ5RoXwROnKMUE3PEwDOKM4"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPCOIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<LPCOIN>>(0x2::coin_registry::finalize<LPCOIN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

