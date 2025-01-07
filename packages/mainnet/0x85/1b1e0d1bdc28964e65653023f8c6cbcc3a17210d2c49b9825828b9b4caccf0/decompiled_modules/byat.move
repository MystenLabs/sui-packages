module 0x851b1e0d1bdc28964e65653023f8c6cbcc3a17210d2c49b9825828b9b4caccf0::byat {
    struct BYAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BYAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BYAT>(arg0, 6, b"BYAT", b"Sui Byat", b"$BYAT - Bonk Goes Gyat!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/combined_image_2_f94de319c2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BYAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BYAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

