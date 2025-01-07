module 0x4dcd0ed67a084e2175b1f50f0cd382316343513653a10ba223028ddd9cd2147b::samurai {
    struct SAMURAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMURAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAMURAI>(arg0, 6, b"SAMURAI", b"$SAMURAI", b"Katanas should always be sharpened", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5852_f987f0f438.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMURAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAMURAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

