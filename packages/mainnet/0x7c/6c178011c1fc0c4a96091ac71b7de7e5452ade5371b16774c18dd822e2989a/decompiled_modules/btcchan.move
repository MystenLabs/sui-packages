module 0x7c6c178011c1fc0c4a96091ac71b7de7e5452ade5371b16774c18dd822e2989a::btcchan {
    struct BTCCHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCCHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"c115fe00722082140dfd92e2b6d1ca845a9ddee6aadfae946e48cb662383de70                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BTCCHAN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BTCCHAN     ")))), trim_right(b"Bitcoin-Chan                    "), trim_right(x"426974636f696e2d4368616e20244254434348414e0a0a426974636f696e20416e696d65206d6173636f740a0a426974636f696e2d4368616e2077617320626f726e206f7665722031322079656172732061676f206f6e20526564646974206265666f72652063727970746f206861642068697420746865206d61696e73747265616d2e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCCHAN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTCCHAN>>(v4);
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

