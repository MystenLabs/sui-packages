module 0x89da4ec42b6ca1faf527af333a86bd9c9f76d0f3cc4262de5d13377dba95ad12::ghibliai {
    struct GHIBLIAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHIBLIAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/yQu4djpX7zxez9y6pARYqBjfnPDC4ZtqYsJCvT4pump.png                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GHIBLIAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GHIBLIAI    ")))), trim_right(b"Ghibli Ai                       "), trim_right(b"AI that turns your ideas and stories into magical illustrations in the style ofStudioGhibli.                                                                                                                                                                                                                                    "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHIBLIAI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GHIBLIAI>>(v4);
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

