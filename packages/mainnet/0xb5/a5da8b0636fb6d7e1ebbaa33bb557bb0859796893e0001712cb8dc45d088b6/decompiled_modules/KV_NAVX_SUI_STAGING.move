module 0xb5a5da8b0636fb6d7e1ebbaa33bb557bb0859796893e0001712cb8dc45d088b6::KV_NAVX_SUI_STAGING {
    struct KV_NAVX_SUI_STAGING has drop {
        dummy_field: bool,
    }

    fun init(arg0: KV_NAVX_SUI_STAGING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KV_NAVX_SUI_STAGING>(arg0, 6, b"KV_SUI_USDC", b"KV_SUI_USDC", b"staging kriya clmm vault token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KV_NAVX_SUI_STAGING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KV_NAVX_SUI_STAGING>>(v1);
    }

    // decompiled from Move bytecode v6
}

