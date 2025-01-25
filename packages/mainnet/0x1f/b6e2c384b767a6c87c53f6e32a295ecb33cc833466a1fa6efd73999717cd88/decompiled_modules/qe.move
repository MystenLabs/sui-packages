module 0x1fb6e2c384b767a6c87c53f6e32a295ecb33cc833466a1fa6efd73999717cd88::qe {
    struct QE has drop {
        dummy_field: bool,
    }

    fun init(arg0: QE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"WNAUQSJWjEz4Q9Qn                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<QE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"QE          ")))), trim_right(b"Quantitative Easing Index       "), trim_right(x"496e7374656164206f662073696d706c7920686f70696e6720666f72205175616e746974617469766520456173696e6720746f20626567696e206f6e204a616e756172792032392c20323032352c206c657427732074616b6520616374696f6e20616e642069676e69746520616e20616c74736561736f6e2063656e74657265642061726f756e642074686520514520746f6b656e21200d0a0d0a54686520514520746f6b656e206973206d6f7265207468616e206a75737420612063727970746f69747320616e20696e646578206f6620686f7065202c2064657369676e656420746f206361707475726520746865206f7074696d69736d20616e6420656e65726779206f6620616e20616c74736561736f6e206675656c6564206279206c697175696469747920616e64206d61726b6574206d6f6d656e74756d2e200d0a"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QE>>(v4);
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

