module 0x68fdf83825ff2705be3383b75b8a2d4cf148f94ea90feab6a9dc337277ede697::bonzi {
    struct BONZI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONZI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONZI>(arg0, 6, b"BONZI", b"BONZI THE BEAR", b"Born from every rug, bad call, and red candle, $BONZI is a satire on the chaos of crypto and traditional markets. A tribute to poor investment decisions and eternal pessimism, this little bear embraces the wreckage  and laughs through it. Join $BONZI and celebrate the art of losing... in style.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/x2_ac643d4b66.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONZI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONZI>>(v1);
    }

    // decompiled from Move bytecode v6
}

