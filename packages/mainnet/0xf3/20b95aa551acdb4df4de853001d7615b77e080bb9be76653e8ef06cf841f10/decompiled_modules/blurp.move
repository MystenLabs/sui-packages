module 0xf320b95aa551acdb4df4de853001d7615b77e080bb9be76653e8ef06cf841f10::blurp {
    struct BLURP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLURP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLURP>(arg0, 6, b"BLURP", b"SuBlurp", b"Blrup just wobbled around till he arrived here on MovePump, he is made out of slime and goo, and with a lot of love from children all around the world, get in and wobble around with him to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_c8a4e5d024.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLURP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLURP>>(v1);
    }

    // decompiled from Move bytecode v6
}

