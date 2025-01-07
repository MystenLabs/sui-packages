module 0x2dbf4510306e1f1af1b8f05ec44e1421925d8051d93fc1b458d8ad971fad1e41::trumpav {
    struct TRUMPAV has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPAV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPAV>(arg0, 6, b"TRUMPAV", b"Trump AnimeVerse", b"rump AnimeVerse is the perfect fusion of anime energy and meme culture, featuring a unique anime style Trump as the star of the show. Dive into a world where Trump meets anime, creating a captivating universe of bold visuals, creativity, and community driven excitement!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_02_21_46_14_62ba2b32fc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPAV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPAV>>(v1);
    }

    // decompiled from Move bytecode v6
}

