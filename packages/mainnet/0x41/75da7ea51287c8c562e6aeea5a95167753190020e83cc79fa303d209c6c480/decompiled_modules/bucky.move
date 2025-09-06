module 0x4175da7ea51287c8c562e6aeea5a95167753190020e83cc79fa303d209c6c480::bucky {
    struct BUCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"e0fd40ca9b1a4062b23b0bcf53dfccc39b309baa1743507a2868bbf80d0c12b4                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BUCKY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Bucky       ")))), trim_right(b"Bucky                           "), trim_right(x"4275636b792069732061206272696768742d677265656e2072656c6963206f6620346368616e206c6f726520206120666c61742d66616365642c206e6f6e6368616c616e742063686172616374657220626f726e20666f7220627261696e726f742068756d6f722e200a0a486973206e616d6520777269746573207468652068756d6f7220616e6420736574732074686520706174683a2031204275636b2c2035204275636b732c203130204275636b7320616c776179732063686173696e672068697320747275652076616c75652e0a0a4a75737420646f6e27742067657420696e20686973207761792e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUCKY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUCKY>>(v4);
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

