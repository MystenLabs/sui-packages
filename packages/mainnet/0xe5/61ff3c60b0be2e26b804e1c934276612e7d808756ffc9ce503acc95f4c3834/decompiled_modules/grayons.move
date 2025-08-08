module 0xe561ff3c60b0be2e26b804e1c934276612e7d808756ffc9ce503acc95f4c3834::grayons {
    struct GRAYONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRAYONS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6JrxRg66koyyydtmNz1Ho7YG1QfV3ThB8myFhFMqpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GRAYONS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GRAYONS     ")))), trim_right(b"Mmm grayons                     "), trim_right(x"4d6d6d20677261796f6e730a0a4a6f696e2075732061732077652065617420677265656e2067616e646c6573207570207468652063686172747321205468652070657266656374206d656d6520666f7220677261796f6e20656174696e6720646567656e7320616e6420726574617264732e205468697320346368616e206d656d65206973207375726520746f2073656e6420757320616c6c20746f20746865206d6f6f6e210a0a536f6d65206d656d6573206e6576657220646965202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRAYONS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRAYONS>>(v4);
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

