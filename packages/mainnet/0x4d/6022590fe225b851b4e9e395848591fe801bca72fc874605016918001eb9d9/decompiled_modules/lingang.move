module 0x4d6022590fe225b851b4e9e395848591fe801bca72fc874605016918001eb9d9::lingang {
    struct LINGANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LINGANG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7DKFa79o6QfbGGEtBZ5ZYBJw1qLJWyNuVoMD5rxbpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LINGANG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Lingang     ")))), trim_right(b"Lin Gang Melon                  "), trim_right(b"Lin Gang Melon is a viral internet meme featuring a melon as an animated character in a whimsical world of villainous hero conspiracies and dramatic skits, captivating millions with its absurd humor and intricate storyline embedded into its short videos for keen-eyed fans to discover.                                   "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LINGANG>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LINGANG>>(v4);
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

