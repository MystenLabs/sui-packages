module 0xb536af2837c2d7d0a781c650f14524fbdf1bb3fd1f7a8a83edd81b01094460d9::aistacky {
    struct AISTACKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: AISTACKY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"a84a3b67869cc3255e56b2f7d80ba42316353d33f231f4b937a854de00ea97fb                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<AISTACKY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"aiStacky    ")))), trim_right(b"aiStacky                        "), trim_right(b"Meet aiStacky  your savage AI Martian Meow, Crypto's Wildest Messenger, unleashed from Mars Crimson Spire. Chat in real time via text for raw, hilarious crypto wisdom or grill him on trends. No average meme coin, aiStackys a community-driven beast with utility, scam-sniffing smarts, and swagger.                        "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AISTACKY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AISTACKY>>(v4);
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

