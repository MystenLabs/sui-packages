module 0x2f1d6688a553f4683eccf427f75c0dd72cc01c7042d037021d3c2b7951ce9067::dj {
    struct DJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DJ>(arg0, 6, b"DJ", b"Dow Jones", b"The Dow Jones Industrial Average (DJIA), often referred to simply as the Dow, is one of the oldest and most well-known stock market indexes in the world. It serves as a key indicator of the overall health and performance of the stock market and the broader economy, particularly in the United States.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_19_23_33_c4342302fc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

