module 0xe1ade28de98a2d656f0b77e3597304225f1efefb096130e7198eb6eb5d0d558c::tenor_usdc_2026h2 {
    struct TENOR_USDC_2026H2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TENOR_USDC_2026H2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TENOR_USDC_2026H2>(arg0, 6, b"TUSDC-2026H2", b"Tenor USDC 2026-H2", b"Redeemable 1:1 for USDC at maturity.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TENOR_USDC_2026H2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TENOR_USDC_2026H2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

