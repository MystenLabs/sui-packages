module 0xeb218484105c7192f46e9e52640295e6224a6416e59f6bb7ce973d0dcacd37ed::KV_LP_COIN {
    struct KV_LP_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KV_LP_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KV_LP_COIN>(arg0, 6, b"KV_LP_COIN", b"KV_SUI_USDC", b"staging kriya clmm vault token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KV_LP_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KV_LP_COIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

