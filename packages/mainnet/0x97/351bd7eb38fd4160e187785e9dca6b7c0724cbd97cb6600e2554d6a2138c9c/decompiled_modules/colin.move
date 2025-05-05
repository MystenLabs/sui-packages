module 0x97351bd7eb38fd4160e187785e9dca6b7c0724cbd97cb6600e2554d6a2138c9c::colin {
    struct COLIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COLIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8rN9Zgb5kKqAgeJApZEJPyjRXSKJURghAgghY4uNpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<COLIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Colin       ")))), trim_right(b"Fuck Coorporate America         "), trim_right(b"This is me. My name is Colin. I started investment banking 9 years ago and now am in asset management at a top NYC firm. But life feels stale. A few months back, I stumbled on pumpfun and for the first time in a long time, I actually had some fun. I told two close colleagues about it, huge mistake. Word got around, HR "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COLIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COLIN>>(v4);
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

