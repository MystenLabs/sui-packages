module 0x85a2494a7e5c54236e04f80737d62e5c8e3690d1dc693268829866f6843928d::otc {
    struct OTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"B1f-USp-BW9ID2CN                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<OTC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"OTC         ")))), trim_right(b"Official Trump Card $OTC        "), trim_right(x"4f6666696369616c205472756d7020436172642028244f5443290d0a0d0a57656c636f6d6520746f204f6666696369616c205472756d7020436f696e2028244f54432974686520756c74696d617465206d656d6520636f696e20706179696e67207472696275746520746f20746865206d616e2c20746865206d6f76656d656e742c20616e6420746865206c6567656e642e20546869732069736e74206a75737420616e6f74686572206469676974616c2061737365743b2069747320746865206f6666696369616c20666c6578206f66207468652063727970746f20776f726c642e204675656c656420627920686973206c617465737420616e6e6f756e63656d656e74206f66207468652035206d696c6c696f6e206361726420676f696e6720696e746f2065666665637420736f6f6e0d0a0d0a54686520476f6c642053"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OTC>>(v4);
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

