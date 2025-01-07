module 0x23a527865dd54757da5dbecd2d8e923e4d9cf13735790a765a996b41d07a7d1f::loru {
    struct LORU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LORU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LORU>(arg0, 6, b"LORU", b"Louis Ru", b"It's a meme that will build a community from scratch.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/meme_millonario_1d6418d97b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LORU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LORU>>(v1);
    }

    // decompiled from Move bytecode v6
}

