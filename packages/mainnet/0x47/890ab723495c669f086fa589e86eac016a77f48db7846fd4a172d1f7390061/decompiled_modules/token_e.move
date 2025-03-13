module 0x47890ab723495c669f086fa589e86eac016a77f48db7846fd4a172d1f7390061::token_e {
    struct TOKEN_E has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN_E, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN_E>(arg0, 9, b"TKNE", b"TOKEN_E", b"Test token E", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.coingecko.com/coins/images/279/standard/ethereum.png")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TOKEN_E>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN_E>>(v1);
    }

    // decompiled from Move bytecode v6
}

