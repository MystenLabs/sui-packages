module 0x1d35bffc09a3836cba66d2d4df33b8c07a37432a06b7d897416e4784a9376d46::budzburn {
    struct BUDZBURN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUDZBURN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"2a1bf30751dd9ccaa4c04710859f5386cf08377598a63e9be560d5827b54674d                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BUDZBURN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BUDZBURN    ")))), trim_right(b"The Budzburn Show               "), trim_right(x"4261636b6564206279206f7572205265616c2d576f726c642044697370656e73617279202d20416c72656164792067656e65726174696e67206d696c6c696f6e7320696e20766572696669656420726576656e75652e0a0a4c6976652053747265616d696e67204461696c792d554e4355542026205241572d44697370656e736172792073686f70207475726e656420736974636f6d207c204f75722068696c6172696f75732c206372617a79206372657720676f6573204c4956452065766572792073696e676c6520776f726b646179207c20506f7765726564206279206f7572206d656d6520636f696e20244255445a4255524e207c204c495645206f6e2050756d702e46756e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUDZBURN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUDZBURN>>(v4);
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

