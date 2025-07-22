module 0xf0576b5533b4f6be152e2d3d58a4ebba2634df371fb9c03da05a670263fc82ba::brainrot {
    struct BRAINROT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAINROT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/CMoywC4fwDAnfPxXxx8vjBnDYCg3KJ1zLa7CFCANbonk.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BRAINROT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BRAINROT    ")))), trim_right(b"Italian Brainrot                "), trim_right(b"Based on 2025 trends from diverse sources like Mashable, KnowYourMeme, and X, the biggest meme is Italian BrainrotAI-generated surreal creatures with pseudo-Italian names (e.g., Ballerina Cappuccina), exploding on TikTok with billions of views, infiltrating culture from toys to movies. It's hailed as the first true AI "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAINROT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRAINROT>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

