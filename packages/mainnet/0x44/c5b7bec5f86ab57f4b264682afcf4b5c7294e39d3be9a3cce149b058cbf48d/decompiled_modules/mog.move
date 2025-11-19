module 0x44c5b7bec5f86ab57f4b264682afcf4b5c7294e39d3be9a3cce149b058cbf48d::mog {
    struct MOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"07f455843fb7fd013eb761a53e8e0951a577d1a36a5d9a74b770d1de79fe9dfa                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MOG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MOG         ")))), trim_right(b"Mother of God                   "), trim_right(x"4d6f74686572206f6620476f6420697320696e7374616e746c79207265616461626c652c20696e7374616e746c792063617074696f6e61626c652c20696e7374616e746c7920766972616c20696e20626f74682062756c6c69736820616e642062656172697368206d6f6d656e74732e2049747320666c657869626c653a204d6f6f6e3f204d6f74686572206f6620476f642e2043686172742074616e6b733f204d6f74686572206f6620476f642e20456c6f6e207477656574733f204d6f74686572206f6620476f642e2045766572792063686172742c2065766572792070756d702c206576657279206d656c74646f776e2020697420666974732e0a0a436f6d65206a6f696e206f757220636f6d6d756e697479206f6e207820616e642074656c656772616d20616e64206c65747320636f6e74696e756520746f206772"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOG>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOG>>(v4);
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

