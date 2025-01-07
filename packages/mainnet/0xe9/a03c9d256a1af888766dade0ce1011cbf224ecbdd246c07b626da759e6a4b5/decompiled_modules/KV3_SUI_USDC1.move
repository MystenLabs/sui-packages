module 0xe9a03c9d256a1af888766dade0ce1011cbf224ecbdd246c07b626da759e6a4b5::KV3_SUI_USDC1 {
    struct KV3_SUI_USDC1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: KV3_SUI_USDC1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KV3_SUI_USDC1>(arg0, 6, b"KV3_SUI_USDC1", b"KV3_SUI_USDC1", b"staging kriya V3 clmm token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KV3_SUI_USDC1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KV3_SUI_USDC1>>(v1);
    }

    // decompiled from Move bytecode v6
}

