module 0x724f8bebe4f950ed0194e77c90b7deb7f51815c877228ac636c32249af604dc::posa {
    struct POSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: POSA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"ecda5e3eb67b8f20841729e83e94bf7ccb541844b4d99a62cfecc2b10f27af7d                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<POSA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"POSA        ")))), trim_right(b"POSA                            "), trim_right(x"4f7572206d697373696f6e2069732073696d706c65207965742070726f666f756e643a200a746f206275696c64206f6e65206f6620746865206772656174657374206d656d6520636f696e73206f6620616c6c2074696d652062792067726f756e64696e67206974206f6e2074687265652070696c6c61727320200a436f6d6d756e6974792c205472616e73706172656e63792c20616e64205265616c2d576f726c6420496d706163742e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POSA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POSA>>(v4);
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

