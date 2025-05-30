module 0xc6348f81b55c804b9114d801c8ae2e1e44ed6742db9ccda2548ad33fe6f42915::meron {
    struct MERON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MERON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MERON>(arg0, 6, b"MERON", b"Sui Meron", b" Sui Meron  The juiciest meme coin on the Sui blockchain!  Sui Meron is a playful fusion of two Japanese words: Sui () meaning water, and Meron () meaning melon. While Sui Meron isnt the direct translation for watermelon in Japanese, it captures the fun spirit of combining liquidity with the sweetness of melons, symbolizing refreshing gains and liquid trading.  Total Supply: 10 billion tokens Slogan: \"Sweet like melons, liquid like water.\"  Whether you're looking for sweet profits or just a refreshing addition to your portfolio, Sui Meron is here to bring you juicy gains and smooth liquidity. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Meron_twitter_profile_525a1fbcf8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MERON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MERON>>(v1);
    }

    // decompiled from Move bytecode v6
}

