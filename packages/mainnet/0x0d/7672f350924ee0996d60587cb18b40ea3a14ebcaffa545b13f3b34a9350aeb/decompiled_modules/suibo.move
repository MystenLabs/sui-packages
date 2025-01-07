module 0xd7672f350924ee0996d60587cb18b40ea3a14ebcaffa545b13f3b34a9350aeb::suibo {
    struct SUIBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/5u4VxhQeqQAbGt1h6YGSqmN7iP2Bi4sBF8hh1CZbpump.png?size=lg&key=9440d4                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SUIBO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SUIBO   ")))), trim_right(b"SUIBO                           "), trim_right(b"Were Gorillaz. Yeah, those Gorillaz. The worlds most iconic animated band. But were not just here to drop tracks and vanish into cartoon limboweve found a new playground. Call it a digital jungle, a place where chaos meets opportunity.                                                                                     "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBO>>(v4);
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

