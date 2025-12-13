module 0x35aad5718d7053f0b39084843dc86f5b2cddf91493f46395f7c3ffac9f494df8::clifford {
    struct CLIFFORD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLIFFORD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"6949542c11db6f039ccf20518e0c56ae3e2cb50bbdc766e2ae04032abc262475                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CLIFFORD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CLIFFORD    ")))), trim_right(b"Clifford The Big MAGA Dog       "), trim_right(x"5468652064657620686173206265656e2073696c656e7420666f7220646179732e0a0a54686520636f6d6d756e69747920697320747279696e6720746f206b656570207468697320616c6976652c2062757420776974686f757420636f6e74726f6c206f6620746865206f6666696369616c2058206163636f756e7420616e64206e6f20636c656172206c6561646572736869702c2070726f6772657373206973206c696d697465642e0a0a43727970746f2072756e73206f6e20617474656e74696f6e2e205820697320657373656e7469616c2e0a576974686f757420616e20616374697665206f6666696369616c2070726573656e63652c206d6f6d656e74756d207374616c6c732e0a0a54686520636f6d6d756e6974792069732072656164792e0a5768617473206d697373696e6720697320646972656374696f6e2e"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLIFFORD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLIFFORD>>(v4);
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

