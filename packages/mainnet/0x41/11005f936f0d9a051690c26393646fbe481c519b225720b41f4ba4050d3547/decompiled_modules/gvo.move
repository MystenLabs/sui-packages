module 0x4111005f936f0d9a051690c26393646fbe481c519b225720b41f4ba4050d3547::gvo {
    struct GVO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GVO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/C2NQZdKGfF1NMAS6LLBUBZ7aqB9Tvy9rtVNXnLWypump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GVO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GVO         ")))), trim_right(b"GoodVibesOnly                   "), trim_right(x"476f6f6456696265734f6e6c79206973206120636f6d6d756e69747920666f6375736564206f6e206275696c64696e672061206c6f6e6720686f6c6420706c61636520746f206368696c6c206163726f737320616c6c20706c6174666f726d732e204e6f20626164207669626573200a0a4120706c61636520746f20666f726765742061626f75742074686520636861727420616e642068616e67206f757420616e64206a7573742072656c61782e205368696c6c20616e64204368696c6c20627574206d6f73746c79206368696c6c2e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GVO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GVO>>(v4);
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

