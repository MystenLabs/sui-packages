module 0xb88a02250e320ed2b5f754423850e4b674164f06c6548d84d2742a96fad3c787::streamer {
    struct STREAMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: STREAMER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"4c807a96bd0ba6a836c79b902597ac1882018194b98888a21186254ce52e5aca                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<STREAMER>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"STREAMER    ")))), trim_right(b"StreamerCoin                    "), trim_right(b"The coin donates 100% of fees to streamers, with the goal of appearing on the donation leaderboard of every top streamer.                                                                                                                                                                                                       "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STREAMER>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STREAMER>>(v4);
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

