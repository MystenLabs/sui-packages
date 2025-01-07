module 0xebbf12cec396b910d0264e1a967fdcc653b34ade40a1068346894e466f0f959f::KV_LP_COIN {
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

