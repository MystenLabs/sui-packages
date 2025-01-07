module 0x9ae0c1f53600f18ea2bedd33ca438c401d161b2a52f443594607814fb1178c87::KV_STAGING_STABLE {
    struct KV_STAGING_STABLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KV_STAGING_STABLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KV_STAGING_STABLE>(arg0, 6, b"KV_STAGING_STABLE", b"KV_SUI_USDC", b"staging kriya clmm vault token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KV_STAGING_STABLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KV_STAGING_STABLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

