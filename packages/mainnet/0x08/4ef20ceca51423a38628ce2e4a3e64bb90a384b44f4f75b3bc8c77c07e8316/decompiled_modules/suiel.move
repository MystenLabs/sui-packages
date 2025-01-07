module 0x84ef20ceca51423a38628ce2e4a3e64bb90a384b44f4f75b3bc8c77c07e8316::suiel {
    struct SUIEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIEL>(arg0, 6, b"SUIEL", b"Sui Elon", b"$SUIEL is a cryptocurrency on Sui blockchain celebrating the innovation and vision of Elon Musk. Unlike traditional tokens, $SUIEL represents exclusive, collectible digital assets inspired by Elon Musk's groundbreaking ventures. Join us in honoring his impact on technology and space exploration with a coin that's as exceptional as its namesake. Get ready for a new era of digital collectibles with $SUIEL!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_10_07_T170855_735_1f933c57ca.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

