module 0x9f3221aa1fa57befaee19b5890f617d38f49088cfc53b0f53a9879569ed47997::dvc {
    struct DVC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DVC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"6bd6ed39b69dead171047f31031caa9e6f5476dea60d033b4fb5182e67710ac3                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DVC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DVC         ")))), trim_right(b"Devcoin                         "), trim_right(b"Devcoin (DVC) is the earliest memecoin/altcoin ever mentioned in the Bitcointalk thread. It was announced on August 5, 2011. It was created to help fund open source projects created by programmers, hardware developers, writers, musicians, painters, graphic artists and filmmakers. Its use-case was somewhat serious, but "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DVC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DVC>>(v4);
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

