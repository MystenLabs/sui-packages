module 0x63a08a8b1972d1e3fdec34bf193631e981bbb14ce0b455d03ecfe10241e24c36::mama {
    struct MAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAMA>(arg0, 6, b"MAMA", b"suimama", b"The Suimama meme coin is a fun and community-driven digital asset built on the Sui blockchain, primarily aiming to capture the spirit of meme culture while delivering utility to its holders. Suimama is inspired by internet trends and humor.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731441257329.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAMA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

