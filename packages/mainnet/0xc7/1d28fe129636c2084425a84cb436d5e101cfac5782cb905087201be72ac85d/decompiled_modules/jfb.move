module 0xc71d28fe129636c2084425a84cb436d5e101cfac5782cb905087201be72ac85d::jfb {
    struct JFB has drop {
        dummy_field: bool,
    }

    fun init(arg0: JFB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"3b081c5414ecc2bc185b9b4f94e90cfdb26bb3a41af204c674ec1e5309b7343c                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<JFB>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"JFB         ")))), trim_right(b"Justice for bagworker           "), trim_right(x"5468657920776f726b65642064617920616e64206e696768742c206e6576657220676f7420706169642c20616e64207374696c6c2068656c6420746865206261672e0a4e6f77207468652062616720666967687473206261636b2e0a4a75737469636520666f7220657665727920626167776f726b65720a363025206f6620616c6c206665657320676f20746f2074686520636f6d6d756e6974792e0a34302520676f657320737472616967687420696e746f206d61726b6574696e672e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JFB>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JFB>>(v4);
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

