module 0xd8222e94ab361986bc086d0285bfd2f369597d2699df217dd44c7f8b428c000c::district47 {
    struct DISTRICT47 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DISTRICT47, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"5Y1Zu8h6MNJ3gg65                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DISTRICT47>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DISTRICT47  ")))), trim_right(b"DISTRICT47                      "), trim_right(x"57656c636f6d6520746f2044495354524943543437776865726520726562656c6c696f6e206d65657473207265766f6c7574696f6e2c20616e642074686520706f776572206f6620646563656e7472616c697a65642066696e616e636520697320707574206261636b20696e746f207468652068616e6473206f662074686f73652077686f206275696c742069742e0d0a0d0a5765207374616e64206174207468652063726f7373726f616473206f6620616e20696e647573747279206f6e6365206675656c65642062792070617373696f6e2c20637265617469766974792c20616e6420696e6e6f766174696f6e2c206e6f772068696a61636b65642062792063656e7472616c697a656420666f726365732c20636f72706f726174652067726565642c20616e64206172746966696369616c20687970652e205768617420"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DISTRICT47>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DISTRICT47>>(v4);
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

