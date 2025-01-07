module 0x45c8109b3139b584fe624b3c75f9854321a04656e8e730ead7dc14e66e79779e::suisc {
    struct SUISC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISC>(arg0, 6, b"SUISC", b"SuiShredder", b"SuiShredder Coin is the ultimate aquatic meme coin inspired by the legendary buff fish, SuiShredder, combining humor, community, and innovation. Built on the fast and low-fee Sui blockchain, SSC features a unique deflationary \"shred\" mechanism, with a portion of every transaction burned to pump the coin's value over time. Holders enjoy \"Bubble Boost\" airdrops, exclusive NFT collections, and a vibrant community dedicated to creating memes and supporting marine conservation. Whether you're in it for the laughs or the gains, SSC is your ticket to flexing hard in the crypto sea. In fins we trust, in memes we swim!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/568df5f4_8ef7_4aed_a5a4_2da68184c920_a7b39bb751.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISC>>(v1);
    }

    // decompiled from Move bytecode v6
}

