module 0xda1f9eaf3d10cd6fa609d3061ac48d640c0aeb36fb031125a263736a0ae0be29::token_b {
    struct TOKEN_B has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN_B, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN_B>(arg0, 9, b"TKNB", b"TOKEN_B", b"Test token B", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TOKEN_B>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN_B>>(v1);
    }

    // decompiled from Move bytecode v6
}

