module 0x3a7409a32fd21638c049253f5c7c0f2e0b6db51b0aa874ae5107fa1e7e418dd8::xtrade {
    struct XTRADE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<XTRADE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<XTRADE>>(0x2::coin::mint<XTRADE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: XTRADE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2vfBxPmHSW2YijUcFCRoMMkAWP9fp8FGWnKxVvJnpump.png?size=lg&key=82ab5c                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<XTRADE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"XTRADE  ")))), trim_right(b"X Trade AI                      "), trim_right(b"X Trade AI is the intelligent chatbot that filters signal from the chaos. From scanning meme trends to analyzing trading patterns, it delivers sharp insights instantly. No fluff, just fast, actionable info  so youre never late to the next big move.                                                                        "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XTRADE>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<XTRADE>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<XTRADE>>(0x2::coin::mint<XTRADE>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

