module 0xc4d622b1ff8c01771596e646cad1ef87e6a76dee21f8e8579ad22fe425a06a0d::zhi {
    struct ZHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZHI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"1111        ");
        let v1 = trim_right(b"https://gateway.irys.xyz/_igy78GPNBJMN9T8-6Cru1t5N1yFeJDcApUteQ3-cQc                                                                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ZHI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ZHI     ")))), trim_right(b"XiaoZhiAI                       "), trim_right(x"5869616f5a68692041492043686174626f7420697320616e206f70656e2d736f7572636520284d4954206c6963656e7365642920736d61727420686172647761726520646576696365206261736564206f6e2045535033322d53332c20696e746567726174696e67204c4c4d73202e200a4f70656e20616464726573733a202068747470733a2f2f6769746875622e636f6d2f37382f7869616f7a68692d65737033322f626c6f622f6d61696e2f524541444d455f656e2e6d642020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZHI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZHI>>(v4);
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

