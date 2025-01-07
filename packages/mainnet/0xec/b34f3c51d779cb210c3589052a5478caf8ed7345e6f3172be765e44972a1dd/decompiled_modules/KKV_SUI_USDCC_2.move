module 0xecb34f3c51d779cb210c3589052a5478caf8ed7345e6f3172be765e44972a1dd::KKV_SUI_USDCC_2 {
    struct KKV_SUI_USDCC_2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: KKV_SUI_USDCC_2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KKV_SUI_USDCC_2>(arg0, 6, b"KKV_SUI_USDCC_2", b"KV_SUI_USDC", b"staging kriya clmm vault token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KKV_SUI_USDCC_2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KKV_SUI_USDCC_2>>(v1);
    }

    // decompiled from Move bytecode v6
}

