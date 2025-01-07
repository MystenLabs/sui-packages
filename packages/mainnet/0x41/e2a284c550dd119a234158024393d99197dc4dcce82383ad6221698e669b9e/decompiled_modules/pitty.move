module 0x41e2a284c550dd119a234158024393d99197dc4dcce82383ad6221698e669b9e::pitty {
    struct PITTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/61tQHzDU1j5aiSKAWpMbEMd7dm7mdY5LNTfvtamxpump.png?size=lg&key=a404f7                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PITTY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PITTY   ")))), trim_right(b"Pitty the pitbull               "), trim_right(b"The Bored $PITTY Kennel Club is all about community, cool NFTs, and making trading fun and rewarding. With our PITTbull trading bot, holders can enjoy passive income while being part of a vibrant, supportive community. We're here to bring value, culture, and a fresh vibe to the Solana ecosystem.                        "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PITTY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PITTY>>(v4);
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

