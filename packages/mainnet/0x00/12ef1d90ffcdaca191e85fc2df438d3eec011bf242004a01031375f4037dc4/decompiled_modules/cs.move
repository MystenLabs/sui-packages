module 0x12ef1d90ffcdaca191e85fc2df438d3eec011bf242004a01031375f4037dc4::cs {
    struct CS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"daa660e68a09c730d8e2902d0de7a88d584a17990f2c706466e7860edaceb2ce                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CS          ")))), trim_right(b"Condom Strike                   "), trim_right(x"4166746572204353474f20576970656420322042696c6c696f6e20446f6c6c61727320544f444159207468652042696767657374204c69717569646174696f6e20696e204353474f20486973746f72790a0a74686579206368616e6765642074686569722070667020746f206120636f6e646f6d20686561642c2064656669616e746c7920612074726f6c6c20746f2074686520636f6d6d756e697479200a0a4353203d20436f6e646f6d20537472696b650a0a63613a2047556856447836624e58355531414b636b7539784e686841447a66617a426147637365455657345a70756d702020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CS>>(v4);
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

