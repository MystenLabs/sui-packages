module 0x3f2747e106726e0d29217bb36467e81d00d511666fcae568a767d15756e565a9::KV4_SUI_USDC4 {
    struct KV4_SUI_USDC4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: KV4_SUI_USDC4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KV4_SUI_USDC4>(arg0, 6, b"KV4_SUI_USDC4", b"KV4_SUI_USDC4", b"staging kriya V3 tetstclmm token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KV4_SUI_USDC4>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KV4_SUI_USDC4>>(v1);
    }

    // decompiled from Move bytecode v6
}

