module 0x96e941c593b373b54ca4a8d485cac90cbfe56bf1fad4a6a7164ad2419ccf1082::bevr {
    struct BEVR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEVR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8o1LgXVuFvRXDqLcJjRdB5JvqqU2Qe1brrvNNetypump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BEVR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BEVR        ")))), trim_right(b"BEVR                            "), trim_right(b"$BEVR isnt just another meme coin  its the key to our upcoming play-to-earn game . With a beaver mascot that chews through dips and a community ready to flood the charts, $BEVR combines meme power with real utility. Holders will be part of a gaming ecosystem where fun meets rewards, and every move drives hype. Why $BEV"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEVR>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEVR>>(v4);
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

