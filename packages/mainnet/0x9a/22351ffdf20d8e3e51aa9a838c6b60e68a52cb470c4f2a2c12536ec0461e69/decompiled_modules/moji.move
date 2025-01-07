module 0x9a22351ffdf20d8e3e51aa9a838c6b60e68a52cb470c4f2a2c12536ec0461e69::moji {
    struct MOJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOJI>(arg0, 6, b"MOJI", b"SUI MOJI", b"Just that big purple emoji that started the Emoji-Fi meta on SUI chain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_16_23_04_10_ee04de7a78.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

