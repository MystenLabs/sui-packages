module 0x294cb37e9efefd459690eb644ebedcefac70d35fd5f3deaee0f5094a3e4c3e6a::auite {
    struct AUITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUITE>(arg0, 6, b"AUITE", b"Andreuuuu Taiiiite", b"In a world full of whiners and losers, embrace your masculinity and rock this crypto meme cycle  with Andreuuuu Taiiiite", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tate_dacaa80aac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUITE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AUITE>>(v1);
    }

    // decompiled from Move bytecode v6
}

