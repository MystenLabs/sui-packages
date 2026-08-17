module 0xfa914e9314136d037e1fee7a4fc88415363532002b328ded2b48525296345323::tenor_usdc_sui_test1 {
    struct TENOR_USDC_SUI_TEST1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TENOR_USDC_SUI_TEST1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TENOR_USDC_SUI_TEST1>(arg0, 6, b"TUSDC-SUI-TEST1", b"Tenor USDC SUI TEST1", b"Redeemable 1:1 for USDC at maturity.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TENOR_USDC_SUI_TEST1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TENOR_USDC_SUI_TEST1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

