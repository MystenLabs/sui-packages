module 0x6673a734a3a766f9a08116d5ef8ddf8317e2cc094794e1b5e50f70c67cbef254::KV_SUI_USDC {
    struct KV_SUI_USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KV_SUI_USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KV_SUI_USDC>(arg0, 6, b"KV_SUI_USDC", b"KV_SUI_USDC", b"staging kriya clmm vault token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KV_SUI_USDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KV_SUI_USDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

