module 0x20bb2f550b753099f21d280473d6f213a005d3897f2139eaedf0d0e3cf6ae703::trashcoin {
    struct TRASHCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRASHCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRASHCOIN>(arg0, 6, b"TRASHCOIN", b"TRASH COIN", b" You're tired of being a trash, feeling worthless and stepped on. It's time to change your life! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_24_15_37_08_cefcc856d2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRASHCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRASHCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

