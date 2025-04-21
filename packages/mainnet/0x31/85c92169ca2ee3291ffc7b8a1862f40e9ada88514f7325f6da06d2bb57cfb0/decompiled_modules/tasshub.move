module 0x3185c92169ca2ee3291ffc7b8a1862f40e9ada88514f7325f6da06d2bb57cfb0::tasshub {
    struct TASSHUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TASSHUB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FKNfAwb8TmjYkj11V4NiTz4TgrLWTWgm2NRwAD9epump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TASSHUB>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TASSHUB     ")))), trim_right(b"TASS HUB                        "), trim_right(b"TassHub is the ultimate degenerate memecoin fueling the world's first adult platform built by crypto degenerates, for crypto degenerates. Think OnlyFans meets Web3, powered by memes, madness, and the magic of Tass. No shame, no filtersjust blockchain-powered pleasure and profit                                          "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TASSHUB>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TASSHUB>>(v4);
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

