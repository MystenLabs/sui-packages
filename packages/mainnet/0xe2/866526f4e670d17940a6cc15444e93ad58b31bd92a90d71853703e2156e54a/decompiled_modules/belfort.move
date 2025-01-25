module 0xe2866526f4e670d17940a6cc15444e93ad58b31bd92a90d71853703e2156e54a::belfort {
    struct BELFORT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELFORT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/276YVgJ1K1xyeyp9t7KTsxmRPW19munwwDSKpkwNpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BELFORT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BELFORT     ")))), trim_right(b"Jordan Belfort                  "), trim_right(x"2442454c464f525420495320484552450a5468652077616974206973206f7665722e20496e73706972656420627920746865206c6567656e64617279204a6f7264616e2042656c666f72742c2074686520576f6c66206f662057616c6c205374726565742c202442656c666f7274206973206e6f77204c49564520616e6420726561647920746f20646f6d696e61746520746865206d656d65636f696e2073706163652e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELFORT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BELFORT>>(v4);
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

