module 0x610280d0c4b0edcb1b6c48c153513dd41bb90abebd11f1c05471254e628ade9::su_usdc {
    struct SU_USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SU_USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SU_USDC>(arg0, 6, 0x1::string::utf8(b"suUSDC"), 0x1::string::utf8(b"su USD Coin"), 0x1::string::utf8(b"Test su USD Coin for the su protocol"), 0x1::string::utf8(b"https://avatars.githubusercontent.com/u/96220676?s=512"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SU_USDC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SU_USDC>>(0x2::coin_registry::finalize<SU_USDC>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

