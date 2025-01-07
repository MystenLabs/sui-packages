module 0xef3403ebe84b96989995119f09539d5b24a09fb828645d67c6c1b4e39ed2c095::suitardio {
    struct SUITARDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITARDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITARDIO>(arg0, 6, b"SUITARDIO", b"SUITARDIO MEME", x"53554954415244494f20574f524c44202052444552207c200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUITARDIO_MEME_5c7e1179a6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITARDIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITARDIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

