module 0x4cb4386e43955a84e251c040acca3175d160038dec16955c6b57eb65c9ad623::mtt {
    struct MTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTT>(arg0, 9, b"MTT", b"mainnet Test Token", b"Token deployed on mainnet", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

