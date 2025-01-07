module 0x40fc341ebc75557f075536ada9cee82126abc0f37c9938ba933b1ac2dcbcfd56::msn {
    struct MSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSN>(arg0, 6, b"MSN", b"Mouse Coin", b"Mouse Coin Meme Coin !!! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Stressed_Mouse_meme_10_d9451a8a27.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSN>>(v1);
    }

    // decompiled from Move bytecode v6
}

