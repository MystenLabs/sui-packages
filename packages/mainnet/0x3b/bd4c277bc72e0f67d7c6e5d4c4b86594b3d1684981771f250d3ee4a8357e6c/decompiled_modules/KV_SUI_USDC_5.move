module 0x3bbd4c277bc72e0f67d7c6e5d4c4b86594b3d1684981771f250d3ee4a8357e6c::KV_SUI_USDC_5 {
    struct KV_SUI_USDC_5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: KV_SUI_USDC_5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KV_SUI_USDC_5>(arg0, 6, b"KV_SUI_USDC", b"KV_SUI_USDC", b"staging kriya clmm vault token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KV_SUI_USDC_5>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KV_SUI_USDC_5>>(v1);
    }

    // decompiled from Move bytecode v6
}

