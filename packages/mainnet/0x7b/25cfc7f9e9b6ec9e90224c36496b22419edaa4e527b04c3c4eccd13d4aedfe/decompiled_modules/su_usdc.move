module 0x7b25cfc7f9e9b6ec9e90224c36496b22419edaa4e527b04c3c4eccd13d4aedfe::su_usdc {
    struct SU_USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SU_USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SU_USDC>(arg0, 6, 0x1::string::utf8(b"suUSDC"), 0x1::string::utf8(b"su USD Coin"), 0x1::string::utf8(b"Test su USD Coin for the su protocol"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SU_USDC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SU_USDC>>(0x2::coin_registry::finalize<SU_USDC>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

