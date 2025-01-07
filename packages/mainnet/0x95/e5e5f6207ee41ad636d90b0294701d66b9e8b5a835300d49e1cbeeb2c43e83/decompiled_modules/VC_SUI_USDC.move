module 0x95e5e5f6207ee41ad636d90b0294701d66b9e8b5a835300d49e1cbeeb2c43e83::VC_SUI_USDC {
    struct VC_SUI_USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: VC_SUI_USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VC_SUI_USDC>(arg0, 6, b"KV_SUI_USDC", b"KV_SUI_USDC", b"staging kriya clmm vault token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VC_SUI_USDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VC_SUI_USDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

