module 0x6b1da6fa87887940d62ee83d744987f7bf12c7b04ab4a85453817bb22700ea2a::quai {
    struct QUAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/D8CQf2zeEXiQgVJoWDy51VQ97DxASuRqHuVSto6Hd7TA.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<QUAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"QUAI        ")))), trim_right(b"Quai Network                    "), trim_right(b"Quai Network is a scalable and programmable Proof-of-Work blockchain designed to serve as a new global monetary system. By merging currency with energy, Quai delivers the worlds first decentralized energy dollar, QI.QI.QI is stable, scalable, and built for real-world commerce. Quai leverages a next-generation Proof-of-"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUAI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUAI>>(v4);
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

