module 0x701321baf1d70ffca170b719ddcc36020ab554cfec7c59c9ec4751aa8d81413::lpcoin {
    struct LPCOIN has key {
        id: 0x2::object::UID,
    }

    public fun new(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<LPCOIN>(arg0, 6, 0x1::string::utf8(b"HAEDAL-USDC Vault LPT"), 0x1::string::utf8(b"HAEDAL-USDC Haedal Vault LP Token"), 0x1::string::utf8(b"Haedal Vault LP Token, HAEDAL-USDC Pool"), 0x1::string::utf8(b"https://node1.irys.xyz/BfoQ4ytPwL9vQGgXZ9OZOjkjQDgqiRHpsa635mdOG8k"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LPCOIN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<LPCOIN>>(0x2::coin_registry::finalize<LPCOIN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

