module 0x42743fe824791abf773631291cb9f7b4a37908e3a2619eb1bf9ac9faf6104af4::uni {
    struct UNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"073086b3eea1ca4890152b1a03cac1a0ba25ad349a8aaeb54b78c883a4ef0272                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<UNI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Uni         ")))), trim_right(b"Uni                             "), trim_right(x"43656c6562726174652074686520556e69737761702d536f6c616e6120436f6c6c61626f726174696f6e207769746820554e4920546f6b656e2043544f210a0a496e20686f6e6f72206f6620746865206578636974696e6720696e746567726174696f6e206265747765656e20556e697377617020616e6420536f6c616e612e0a0a54686973207370656369616c20746f6b656e2073796d626f6c697a657320746865206272696467696e67206f662074776f20706f776572686f7573652065636f73797374656d732e0a0a31303025206f662063726561746f7220726577617264732067656e6572617465642066726f6d207468697320696e69746961746976652077696c6c20626520616c6c6f636174656420746f206275796261636b7320616e64206275726e73206f662074686520554e4920636f6d6d656d6f726174"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNI>>(v4);
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

