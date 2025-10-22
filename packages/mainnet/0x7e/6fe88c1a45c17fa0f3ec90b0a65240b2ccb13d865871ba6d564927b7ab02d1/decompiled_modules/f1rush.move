module 0x7e6fe88c1a45c17fa0f3ec90b0a65240b2ccb13d865871ba6d564927b7ab02d1::f1rush {
    struct F1RUSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: F1RUSH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"42fbaeb42e853dd678116d83fdf5998d0545b0506f3038ee082ab27b16c05fc5                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<F1RUSH>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"F1RUSH      ")))), trim_right(b"F1Rush                          "), trim_right(x"2046312052757368202846315255534829202054686520616472656e616c696e652d6368617267656420746f6b656e2074656172696e67207468726f7567682074686520576562332066617374206c616e652e204275696c7420666f722073706565642c20707265636973696f6e2c20616e6420706f7765722c20463152555348206d65726765732074686520746872696c6c206f6620466f726d756c61203120776974682063727970746f206d656d6520706f7765722e0a0a204261636b6564206279206c6f636b6564206c69717569646974792c204631525553482069732064657369676e656420666f7220463120656e7468757369617374732077686f2077616e74206d6f7265207468616e206a75737420687970652e200a0a20537461727420796f757220656e67696e657320204631525553482069736e74206865"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<F1RUSH>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<F1RUSH>>(v4);
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

