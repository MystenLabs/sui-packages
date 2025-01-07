module 0x45a8ffac257de37e5b338f058e082f9360b93aeca3d8a8fe65046917c4dd1754::KV_SUI_USDC_3 {
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

