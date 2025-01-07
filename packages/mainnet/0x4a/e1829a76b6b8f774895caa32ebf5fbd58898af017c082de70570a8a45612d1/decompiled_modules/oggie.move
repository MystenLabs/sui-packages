module 0x4ae1829a76b6b8f774895caa32ebf5fbd58898af017c082de70570a8a45612d1::oggie {
    struct OGGIE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<OGGIE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<OGGIE>>(0x2::coin::mint<OGGIE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: OGGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GjDkKyWds4Jkz7Y6wEyJHuy5TtKF5VUMeCcRMci4pump.png?size=lg&key=986e7a                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<OGGIE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"OGGIE   ")))), trim_right(b"Real origins of Pepe            "), trim_right(b"OGGIE is the inspiration for Matt Furies Pepe, originating in R. Crumbs Big Yum Yum Book. Created in 1964, OGGIEs journey cements him as an OG figure in both comics and crypto, with the community dubbing him the true grandfather of meme coins.                                                                             "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OGGIE>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<OGGIE>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<OGGIE>>(0x2::coin::mint<OGGIE>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

