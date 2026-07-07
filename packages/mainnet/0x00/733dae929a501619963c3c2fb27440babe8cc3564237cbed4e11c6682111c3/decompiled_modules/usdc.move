module 0x733dae929a501619963c3c2fb27440babe8cc3564237cbed4e11c6682111c3::usdc {
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

