module 0x3e99b11cee0ad6a4d5917892c0e43451c7ffa905061fbde925391ee80ff330e7::advance {
    struct ADVANCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADVANCE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"5a478bebd412906140812e59cf5e3dbb780218c112910dfb6ede115466b1ec46                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ADVANCE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ADVANCE     ")))), trim_right(b"Advance UK                      "), trim_right(x"416476616e636520554b2043727970746f2050726f6a65637420286f6e2042414753290a4120636f6d6d756e6974792d64726976656e20746f6b656e206372656174656420746f20737570706f727420416476616e636520554b73206d697373696f6e20746f206272696e67207265616c206368616e676520746f2074686520554b2e2031303025206f662074686520666565732066726f6d20657665727920747261646520676f206469726563746c7920746f776172642066756e64696e6720616374697669736d2c20737072656164696e672061776172656e6573732c20616e6420737570706f7274696e67207468652053657074656d62657220313374682070726f7465737420616e6420746865206d616e79207965617273206265796f6e642e20202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADVANCE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADVANCE>>(v4);
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

