module 0xef25b5496d16715de0b4138194d494fbb933cb9ac5fc69d7f4261c1b46d2bc34::douyin {
    struct DOUYIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOUYIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOUYIN>(arg0, 6, b"DOUYIN", b"Douyin Coin", b"Douyin - the Chinese version of TikTok", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250123_225302_627_e9891a3093.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOUYIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOUYIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

