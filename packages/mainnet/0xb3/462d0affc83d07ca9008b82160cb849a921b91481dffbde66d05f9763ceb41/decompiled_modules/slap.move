module 0xb3462d0affc83d07ca9008b82160cb849a921b91481dffbde66d05f9763ceb41::slap {
    struct SLAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLAP>(arg0, 6, b"SLAP", b"MEOWSLAP", b"MEOWSLAP, SLAP EVERYTHING !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_29_03_04_24_39458ed87c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

