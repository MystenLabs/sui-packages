module 0x374be61266537f78dc9a79e7b750f26606e6cdb4a611b4b52ed949f8a66b73fa::KV_SUI_USDC_7 {
    struct KV_SUI_USDC_7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: KV_SUI_USDC_7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KV_SUI_USDC_7>(arg0, 6, b"KV_SUI_USDC", b"KV_SUI_USDC", b"staging kriya clmm vault token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KV_SUI_USDC_7>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KV_SUI_USDC_7>>(v1);
    }

    // decompiled from Move bytecode v6
}

