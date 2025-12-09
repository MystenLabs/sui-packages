module 0x7532f87d9c3e77df433a0d1cc1da1a79d6b9d8ab1e5d45dd7add55eda7fbadb0::ice {
    struct ICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"9feab98bae7be3d7897364dcb0258045933cacd7155b3c605d4c32d5b71a6189                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ICE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ICE         ")))), trim_right(b"Ice                             "), trim_right(x"4943452074686520646f67207468617420676f74207265736375656420627920494345210a0a4162757365642c206d616c6e6f757269736865642c20616e64206162616e646f6e65642c2074686973206c6974746c652067757920776173207265736375656420647572696e67206120466c6f72696461204869676877617920506174726f6c20696d6d6967726174696f6e206f7065726174696f6e20696e20536f75746820466c6f726964612e0a0a4865207761732061646f70746564206279206f757220696d6d6967726174696f6e20656e666f7263656d656e7420657865637574697665206469726563746f722c2077686f20686173206e616d65642068696d20494345210a0a5553443120636f64656420646f672072756e6e65722e2020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ICE>>(v4);
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

