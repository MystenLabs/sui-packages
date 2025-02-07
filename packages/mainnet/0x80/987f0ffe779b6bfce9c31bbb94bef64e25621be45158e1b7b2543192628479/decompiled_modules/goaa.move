module 0x80987f0ffe779b6bfce9c31bbb94bef64e25621be45158e1b7b2543192628479::goaa {
    struct GOAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOAA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"cIEsDL6Crhp6qfEX                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GOAA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GOA         ")))), trim_right(b"GulfOfAmerica                   "), trim_right(x"24474f413a2047756c66206f6620416d657269636120204472696c6c20426162792c204472696c6c0d0a0d0a42757920616e64207374616b6520796f75722024474f41206e6f7720746f20736563757265206120746f702073706f7420696e2074686520474f4120636f696e207265766f6c7574696f6e2e204561726c79207374616b657273206761696e206578636c75736976652061636365737320746f2041492d706f77657265642070726f66697473626520612070617274206f6620746865206a6f75726e65792066726f6d20746865207374617274210d0a0d0a576974682074686520676f2d61686561642066726f6d20746865206f6666696369616c205472756d70205465616d20686572652077652061726521202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOAA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOAA>>(v4);
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

