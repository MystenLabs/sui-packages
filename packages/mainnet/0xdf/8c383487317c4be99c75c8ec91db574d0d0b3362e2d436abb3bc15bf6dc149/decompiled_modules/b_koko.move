module 0xdf8c383487317c4be99c75c8ec91db574d0d0b3362e2d436abb3bc15bf6dc149::b_koko {
    struct B_KOKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_KOKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_KOKO>(arg0, 9, b"bKOKO", b"bToken KOKO", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_KOKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_KOKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

