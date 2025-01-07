module 0xc07ad5f18434ab9124b17f74756c201b1babaadbee5e4b810a7010e291df93d9::KKV_SUI_USDCC_1 {
    struct KKV_SUI_USDCC_1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: KKV_SUI_USDCC_1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KKV_SUI_USDCC_1>(arg0, 6, b"KKV_SUI_USDCC_1", b"KV_SUI_USDC", b"staging kriya clmm vault token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KKV_SUI_USDCC_1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KKV_SUI_USDCC_1>>(v1);
    }

    // decompiled from Move bytecode v6
}

