module 0x96e1acdb90e080bcfc9e7bc6ddf9610c87a642df863188d554dedfa2310f3034::KV3_SUI_USDC2 {
    struct KV3_SUI_USDC2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: KV3_SUI_USDC2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KV3_SUI_USDC2>(arg0, 6, b"KV3_SUI_USDC2", b"KV3_SUI_USDC2", b"staging kriya V3 clmm token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KV3_SUI_USDC2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KV3_SUI_USDC2>>(v1);
    }

    // decompiled from Move bytecode v6
}

