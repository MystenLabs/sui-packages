module 0x97631893d11beb16680163ce49082f56bebd3169cd5f065465635143b20a7d1b::KV_SUI_USDC_3 {
    struct KV_SUI_USDC_3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: KV_SUI_USDC_3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KV_SUI_USDC_3>(arg0, 6, b"KV_SUI_USDC", b"KV_SUI_USDC", b"staging kriya clmm vault token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KV_SUI_USDC_3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KV_SUI_USDC_3>>(v1);
    }

    // decompiled from Move bytecode v6
}

