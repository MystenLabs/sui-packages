module 0x15007a348c55fa48bfd5f5059ca8b2d511f41f7741b1931c2777ca06c8efe386::KV_SUI_USDC_1 {
    struct KV_SUI_USDC_1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: KV_SUI_USDC_1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KV_SUI_USDC_1>(arg0, 6, b"KV_SUI_USDC", b"KV_SUI_USDC", b"staging kriya clmm vault token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KV_SUI_USDC_1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KV_SUI_USDC_1>>(v1);
    }

    // decompiled from Move bytecode v6
}

