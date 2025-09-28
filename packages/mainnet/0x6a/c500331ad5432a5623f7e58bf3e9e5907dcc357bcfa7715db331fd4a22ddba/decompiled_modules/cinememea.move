module 0x6ac500331ad5432a5623f7e58bf3e9e5907dcc357bcfa7715db331fd4a22ddba::cinememea {
    struct CINEMEMEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CINEMEMEA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"c355945f3368c887a5ef87604d60f9965b5daa2f11642cb3f3929bc0a3463e47                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CINEMEMEA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Cinememe    ")))), trim_right(b"Cinememe - Buy, Tag, Laugh      "), trim_right(x"2443696e656d656d6520697320746865206d656d65636f696e2074686174207472616e73666f726d7320796f7572206661766f7269746520626c6f636b627573746572206d6f7669657320696e746f2068696c6172696f75732c20736861726561626c65206d656d65732c20706f7765726564206279206f757220636f6d6d756e69747973206661766f7269746520636f696e2e0a0a594f5520646563696465207468652076696265212046726f6d2069636f6e6963206f6e652d6c696e65727320746f206c6567656e64617279207363656e65732c2077657265206d656d65696679696e672063696e656d6120686973746f72792c206f6e6520746f6b656e20617420612074696d652e200a0a486f77207468697320776f726b733a0a427579202443696e656d656d653a204772616220746f6b656e732c206a6f696e2074"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CINEMEMEA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CINEMEMEA>>(v4);
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

