module 0x8e5290545a980811f77629e15a329a90562166c39cfa9756c0b3be2a015dcadc::mnvt {
    struct MNVT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNVT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"lHp8EZt8tMyw9O2U                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MNVT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MNVT        ")))), trim_right(b"MoonVault Ai                    "), trim_right(x"4d6f6f6e5661756c742041693a20486f6c6420746865204d6f6f6e2c20556e6c6f636b20746865205661756c74210d0a4d6f6f6e5661756c742041692069732074686520756c74696d617465206d656d6520636f696e20776974682061206d697373696f6e20746f206d616b652063727970746f2066756e2c20656e676167696e672c20616e6420726577617264696e672e2044657369676e656420746f206361707469766174652074686520696d6167696e6174696f6e206f662063727970746f20656e7468757369617374732c204d6f6f6e5661756c742020416920636f6d62696e6573206578636974696e67206769766561776179732c20636f6d6d756e6974792d64726976656e20726577617264732c20616e64206120766973696f6e20746f207265616368207468652073746172732e2057652062656c69657665"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNVT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MNVT>>(v4);
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

