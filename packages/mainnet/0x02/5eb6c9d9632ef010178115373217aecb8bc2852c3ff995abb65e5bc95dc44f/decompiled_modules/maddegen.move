module 0x25eb6c9d9632ef010178115373217aecb8bc2852c3ff995abb65e5bc95dc44f::maddegen {
    struct MADDEGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MADDEGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"6030b0b88aa94dffe24b36c8c661563180f14c9ed2bd82c7431dc0e52891313f                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MADDEGEN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MadDegen    ")))), trim_right(b"MAD                             "), trim_right(x"4d6164446567656e202057657265206e6f7420747261646572732c206e6f742073756974732c206e6f742074686520757375616c2063726f77642e2057657265207075726520646567656e20656e657267792c206275696c64696e6720616e6420706c6179696e6720746865206c6f6e672067616d652e204120636f6d6d756e6974792064726976656e20627920687970652c206d61646e6573732c20616e6420636f6e76696374696f6e2e0a0a5765656b6c7920636f6d7065746974696f6e7320746f2077696e20534f4c20616e6420535550504c59210a0a4d414420444547454e53204e455645522053544f50202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MADDEGEN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MADDEGEN>>(v4);
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

