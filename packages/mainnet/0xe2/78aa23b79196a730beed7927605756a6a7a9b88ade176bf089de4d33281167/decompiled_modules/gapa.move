module 0xe278aa23b79196a730beed7927605756a6a7a9b88ade176bf089de4d33281167::gapa {
    struct GAPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAPA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"Yd_2Ks2g6PLAyvrR                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GAPA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GAP         ")))), trim_right(b"Grow-A-Pair                     "), trim_right(x"47726f7720612050616972202824474150293a2054686520756c74696d617465206d656d6520636f696e20666f722074686f73652077686f206461726520746f20686f6c64207468726f75676820746865206469707320616e642073686f772074686569722074727565206772697421202e204669727374206d656e74696f6e6564206f6e2061205820706f73742062792040456c6f6e4d75736b2074686174206761696e6564206d696c6c696f6e73206f6620766965777320696e20686f7572730d0a0d0a54686973206d656d6520636f696e20697320616c6c2061626f75742067726f77696e6720616e6420686f6c64696e6720647572696e672074686520746f7567682074696d65732e204e6f206d6f726520636f6d706c61696e696e672c206e6f206d6f7265207768696e696e672e20497427732074696d6520746f"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAPA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAPA>>(v4);
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

