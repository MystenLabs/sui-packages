module 0x2c5307eeacedbadb8240de3e0de15da4a0bc028bcf55e669b3600cc5874f41c::babymochi {
    struct BABYMOCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYMOCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FeXA9NeSM2u6PwPxsq1Qd5EunhmL2G46hA7TDfbmpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BABYMOCHI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BABYMOCHI   ")))), trim_right(b"BABY MOCHI                      "), trim_right(b"Baby Mochi is a tiny pigeon with a pacifier, a soft heart, and a confused little stare. He doesnt do muchbut somehow, he makes people smile. Hes not here to impress anyone.                                                                                                                                                    "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYMOCHI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYMOCHI>>(v4);
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

