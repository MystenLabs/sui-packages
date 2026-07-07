module 0x7b25cfc7f9e9b6ec9e90224c36496b22419edaa4e527b04c3c4eccd13d4aedfe::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<USDC>(arg0, 6, 0x1::string::utf8(b"USDC"), 0x1::string::utf8(b"USD Coin"), 0x1::string::utf8(b"Test USD Coin for the su protocol"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<USDC>>(0x2::coin_registry::finalize<USDC>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

