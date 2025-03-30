module 0xd8e260b5ca5f3ff9e49c04f97d5a91747bde342067fa6ba475524ed651f77a2c::tita {
    struct TITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/HTgad1fSqVwXHqggqUPHs4wgf8Xnnq2ZKzbgGfRa5Xcy.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TITA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TIt         ")))), trim_right(b"AnimeTits                       "), trim_right(x"486520617070726f616368656420746865205261796469756d20706f6f6c206c696b6520612076697267696e20696e20612077686f7265686f7573652e205377656174792070616c6d732e200a5068616e746f6d206f70656e2e202224544954243f222068652061736b65642e2053686520736d696c65642e20225965732c2064616464792e20496e6a656374206d652e203120534f4c206d696e696d756d2e22204865206f62657965642e0a205468652073637265656e20666c61736865642e205368652073686976657265642e20486572204c502062616c6c6f6f6e65642e20486973206469676e69747920657661706f72617465642e0a2041207768616c6520656e74657265642e20536865206761737065642e20224d6d6d2e2e2e2032306b206275792070726573737572652e2046696c6c206d65206d6f72652e2e"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TITA>>(v4);
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

