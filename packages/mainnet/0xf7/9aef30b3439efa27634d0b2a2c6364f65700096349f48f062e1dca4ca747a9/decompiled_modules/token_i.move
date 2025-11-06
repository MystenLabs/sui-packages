module 0xf79aef30b3439efa27634d0b2a2c6364f65700096349f48f062e1dca4ca747a9::token_i {
    struct TOKEN_I has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN_I, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN_I>(arg0, 9, b"TKNI", b"TOKEN_I", b"Test token I", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.coingecko.com/coins/images/54035/standard/Transparent_bg.png")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TOKEN_I>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN_I>>(v1);
    }

    // decompiled from Move bytecode v6
}

