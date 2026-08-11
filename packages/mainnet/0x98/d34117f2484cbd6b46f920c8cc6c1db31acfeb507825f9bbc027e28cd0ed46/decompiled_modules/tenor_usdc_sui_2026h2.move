module 0x98d34117f2484cbd6b46f920c8cc6c1db31acfeb507825f9bbc027e28cd0ed46::tenor_usdc_sui_2026h2 {
    struct TENOR_USDC_SUI_2026H2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TENOR_USDC_SUI_2026H2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TENOR_USDC_SUI_2026H2>(arg0, 6, b"TUSDC-SUI-2026H2", b"Tenor USDC SUI 2026-H2", b"Redeemable 1:1 for USDC at maturity.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TENOR_USDC_SUI_2026H2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TENOR_USDC_SUI_2026H2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

