module 0x6c56a8dd55ec59e9616a85a47c06142a8e74eee566a474ca6b23a4295a7c3375::stship {
    struct STSHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STSHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GHtLF7drbYXGTHX73uSxqPKkJUzDqcBNe2M9fzjJzr3j.png?claimId=_yUq8qfMTAlpF7qp                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<STSHIP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"STSHIP      ")))), trim_right(b"StarShip                        "), trim_right(x"24535453484950202d205374617273686970206d656d6520636f696e20696e73706972656420627920537061636558277320537461727368697020616e6420456c6f6e204d75736b277320766973696f6e2c2061696d696e6720666f722022746865204d6f6f6e2c204d6172732c20616e64206265796f6e642220776974682065766572792074657374206c61756e6368210a0a245354534849502069732061206d656d6520636f696e2077697468206e6f20696e7472696e7369632076616c7565206f72206578706563746174696f6e206f662066696e616e6369616c2072657475726e2e205468657265206973206e6f20666f726d616c207465616d206f7220726f61646d61702e0a0a576520617265206e6f7420616666696c6961746564207769746820456c6f6e204d75736b206f72205370616365582e2020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STSHIP>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STSHIP>>(v4);
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

