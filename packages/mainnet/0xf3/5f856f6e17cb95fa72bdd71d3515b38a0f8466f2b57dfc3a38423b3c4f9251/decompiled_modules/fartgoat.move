module 0xf35f856f6e17cb95fa72bdd71d3515b38a0f8466f2b57dfc3a38423b3c4f9251::fartgoat {
    struct FARTGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"2d8b64ef5980b73b44811d479b24f94da2db716a63a0df04fcfbdfe31b0eb717                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FARTGOAT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FARTGOAT    ")))), trim_right(b"FARTGOAT                        "), trim_right(x"2446415254474f4154202043544f2e20202054686520536d656c6c69657374205265766f6c7574696f6e206f6e20536f6c616e6121200a5768656e206f74686572732074616c6b2061626f7574206272696467696e672c207765206a7573742046415254206163726f737320636861696e73210a5768656e206f74686572732074616c6b2061626f757420707269766163792c2077652064726f702074686520464152542053494d202074686520776f726c6473206669727374206e6f6e2d4b59432053494d2074686174206b6565707320796f75722067617320616e6420796f7572206461746120707269766174652e0a0a46415254474f41542069736e74206a75737420616e6f74686572206d656d6520206974732061206d6f76656d656e74206f66206d657468616e6520616e64206d6f6f6e73686f74732e0a4f7572"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTGOAT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FARTGOAT>>(v4);
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

