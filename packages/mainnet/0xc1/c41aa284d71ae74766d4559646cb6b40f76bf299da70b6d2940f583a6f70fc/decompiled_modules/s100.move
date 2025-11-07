module 0xc1c41aa284d71ae74766d4559646cb6b40f76bf299da70b6d2940f583a6f70fc::s100 {
    struct S100 has drop {
        dummy_field: bool,
    }

    fun init(arg0: S100, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/72Sp7QibTt8vWoHzvJQ6QA1Pp6UuNjCtRDBdioVSpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<S100>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"S100        ")))), trim_right(b"Solify100                       "), trim_right(b"This isn't your average meme coin. It's a unique blend of fun, technology, and community. With a swarm of AI agents supporting traders at every step, and a reward system that grows with your commitment, it's time to experience a new kind of meme coinone that's built for success.                                         "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S100>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<S100>>(v4);
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

