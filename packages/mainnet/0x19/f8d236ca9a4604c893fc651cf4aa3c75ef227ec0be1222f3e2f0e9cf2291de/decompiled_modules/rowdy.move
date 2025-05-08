module 0x19f8d236ca9a4604c893fc651cf4aa3c75ef227ec0be1222f3e2f0e9cf2291de::rowdy {
    struct ROWDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROWDY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FT2VWubqeuaqW1tQPp5twn6HVCFyc8G9rLw5ByD5pump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ROWDY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ROWDY       ")))), trim_right(b"Rowdy Raccoons                  "), trim_right(x"5468652073747265657473206172652066696c7468792e20546865206d656d6573206172652064616e6b2e20416e642074686520726163636f6f6e733f20526f77647920617320657665722e0a426f726e20696e2074686520646570746873206f662063727970746f206368616f732c20526f77647920526163636f6f6e7320436f696e206973206120636f6d6d756e6974792d706f7765726564206d656d6520746f6b656e206675656c6564206279206d697363686965662c206d656d65732c20616e64206d69646e696768742064756d70737465722072616964732e205768657468657220796f7527726520696e20697420666f7220746865206c6175676873206f7220746865206d6f6f6e206d697373696f6e732c206f6e65207468696e677320666f72207375726520746865736520726163636f6f6e7320646f6e74"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROWDY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROWDY>>(v4);
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

