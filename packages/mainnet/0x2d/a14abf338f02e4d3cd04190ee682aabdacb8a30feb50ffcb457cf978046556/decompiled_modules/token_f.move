module 0x2da14abf338f02e4d3cd04190ee682aabdacb8a30feb50ffcb457cf978046556::token_f {
    struct TOKEN_F has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN_F, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN_F>(arg0, 9, b"TKNF", b"TOKEN_F", b"Test token F", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.coingecko.com/coins/images/12817/standard/filecoin.png")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TOKEN_F>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN_F>>(v1);
    }

    // decompiled from Move bytecode v6
}

