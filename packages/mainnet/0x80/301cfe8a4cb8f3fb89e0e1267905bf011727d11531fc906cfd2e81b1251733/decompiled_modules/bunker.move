module 0x80301cfe8a4cb8f3fb89e0e1267905bf011727d11531fc906cfd2e81b1251733::bunker {
    struct BUNKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNKER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8NCievmJCg2d9Vc2TWgz2HkE6ANeSX7kwvdq5AL7pump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BUNKER>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BUNKER      ")))), trim_right(b"BunkerCoin                      "), trim_right(x"54686520776f726c6473206269676765737420707269766174652062756e6b6572206973207265616c2c206578697374696e6720616e64206f776e65642062792075732e0a0a42756e6b657220436f6f7264696e617465733a2035312e3835373632323232323232322c2031312e3032353831313131313131310a0a42756e6b6572436f696e20697320612070726f6a65637420746861742063726561746573207361666520686176656e7320696e2074696d6573206f6620756e6365727461696e747920616e64206372697369732e2054686520666f637573206973206f6e207468652072656e6f766174696f6e20616e64206d6f6465726e69736174696f6e206f662074686520776f726c642773206c61726765737420707269766174652062756e6b657220666163696c6974792028636f64656e616d65204d616c6163"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNKER>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUNKER>>(v4);
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

