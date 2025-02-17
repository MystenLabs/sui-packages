module 0x1018b0843a724fd966b37f018bbc489918b6594144451cf4b481d392c9a0a463::token_a {
    struct TOKEN_A has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN_A, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN_A>(arg0, 9, b"TKNA", b"TOKEN_A", b"Test token A", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TOKEN_A>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN_A>>(v1);
    }

    // decompiled from Move bytecode v6
}

