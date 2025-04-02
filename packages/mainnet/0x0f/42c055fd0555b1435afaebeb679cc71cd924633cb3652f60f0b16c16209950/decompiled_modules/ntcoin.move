module 0xf42c055fd0555b1435afaebeb679cc71cd924633cb3652f60f0b16c16209950::ntcoin {
    struct NTCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/3cgSBT7zFbw1mUgoC5BKWkn76bJrqro3pgmisarvS2ma.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NTCOIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NTCOIN      ")))), trim_right(b"Nutricoin                       "), trim_right(b"The tastiest way to boost your health and your wallet! This meme coin celebrates nutrition with a playful twist. Every transaction unlocks fun health tips, workout memes, and delicious recipe ideas, promoting a healthy lifestyle. Holders can earn 'NutriPoints' for participating in community challenges like recipe conte"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NTCOIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NTCOIN>>(v4);
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

