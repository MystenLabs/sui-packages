module 0x3993882b58bcdcba1c58eee75d822ba9960d5065577ebeb5dbdc0110d545a5f5::SUI_USDC_V3 {
    struct SUI_USDC_V3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_USDC_V3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_USDC_V3>(arg0, 6, b"SUI_USDC_KV3", b"SUI_USDC_KV3", b"staging kriya V3 vault token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_USDC_V3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_USDC_V3>>(v1);
    }

    // decompiled from Move bytecode v6
}

