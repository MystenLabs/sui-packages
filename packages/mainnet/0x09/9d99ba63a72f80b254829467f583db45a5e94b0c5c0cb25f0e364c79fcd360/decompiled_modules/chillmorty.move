module 0x99d99ba63a72f80b254829467f583db45a5e94b0c5c0cb25f0e364c79fcd360::chillmorty {
    struct CHILLMORTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLMORTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLMORTY>(arg0, 6, b"CHILLMORTY", b"CHILL MORTY", b"Chill Morty is a meme token embodying Mortys laid-back vibe, spreading fun and relaxation in crypto. Hold, chill, and enjoy the ride!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Asset_18_d1eedb3de5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLMORTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLMORTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

