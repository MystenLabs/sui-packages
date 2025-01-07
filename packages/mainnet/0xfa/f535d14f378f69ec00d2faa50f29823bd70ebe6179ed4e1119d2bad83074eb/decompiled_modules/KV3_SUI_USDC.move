module 0xfaf535d14f378f69ec00d2faa50f29823bd70ebe6179ed4e1119d2bad83074eb::KV3_SUI_USDC {
    struct KV3_SUI_USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KV3_SUI_USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KV3_SUI_USDC>(arg0, 6, b"KV3_SUI_USDC", b"KV3_SUI_USDC", b"staging kriya V3 clmm token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KV3_SUI_USDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KV3_SUI_USDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

