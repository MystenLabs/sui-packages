module 0x7efb72e4455e1ecb1fb6cb6b73780deab2b28d9266cf671d790da9d4d38d57db::ufd {
    struct UFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: UFD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"9b5cca5e6b9c8e41bdfb018e671bd2e7f41ce790a95493419ec0a7ac45ef5737                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<UFD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"UFD         ")))), trim_right(b"Unicorn Fart Dust               "), trim_right(x"497427732061204d656d6520436f696e0a4974277320776f7274686c6573733f0a49742069733a20556e69636f726e204661727420447573740a50726f7665206d652077726f6e67210a0a4920616d20612035342079656172206f6c642028616c6d6f73742920626f6f6d65722c203173742074696d652063727970746f20627579657220616e6420737461727465642074686973204d656d6520436f696e20696e203320686f7572732e20492077696c6c20626520636f766572696e672074686973206a6f75726e65792068657265206f6e206d7920596f7554756265206368616e6e656c0a0a49207761732074617567687420746861742073696c76657220616e6420676f6c642061726520746865206f6e6c7920666f726d73206f66207265616c206d6f6e65792c2065766572797468696e6720656c73652069732055"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UFD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UFD>>(v4);
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

