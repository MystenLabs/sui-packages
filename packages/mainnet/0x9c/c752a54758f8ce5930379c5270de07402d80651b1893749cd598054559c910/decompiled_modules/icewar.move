module 0x9cc752a54758f8ce5930379c5270de07402d80651b1893749cd598054559c910::icewar {
    struct ICEWAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICEWAR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BPWhfc7Aus5RwdVFgXBhX8WPk3uHb32VuvrdmVULpump.png?claimId=ZTTMrY9CjOXjJ_OJ                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ICEWAR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"icewar      ")))), trim_right(b"Ice War on Europa               "), trim_right(b"Europa-posting is a creative trend on X where users collaboratively build a sci-fi narrative about a fictional war on Jupiter's moon, Europa. It features memes and posts with themes of extreme cold, cosmic conflict, and exaggerated casualties, like \"BORN TO FREEZE\" and \"410,757,864,530 DEAD WARMIES.\" The meme you refer"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICEWAR>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ICEWAR>>(v4);
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

