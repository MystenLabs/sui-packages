module 0x3b6df3f111f1aba1346fc2770e064716b60ef50177c586694c57a947f3fc8171::dgt {
    struct DGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"4e6627f9d69b1ab4943eb900bdc3af6838901b89b6269880ceada74d4d2a487d                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DGT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DGT         ")))), trim_right(b"DRIVEGT                         "), trim_right(x"24444754202d20447269766547542069732074686520776f726c647320666972737420736f6369616c206e6574776f726b20666f7220636172732e0a4120706c6174666f726d2077686572652063617220656e7468757369617374732063616e20637265617465207468656972206f6e6c696e65206761726167652c2073686f77636173652074686569722076656869636c65732c20636f6e6e6563742077697468206f7468657220647269766572732c20616e642073686172652074686569722070617373696f6e20666f72206361722063756c747572652e0a0a57697468206f7665722036342c3030302b20757365727320616e64203132302c303030206361727320616c7265616479206f6e626f61726465642c2044726976654754206973206275696c64696e67206120676c6f62616c20636f6d6d756e697479206e"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DGT>>(v4);
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

