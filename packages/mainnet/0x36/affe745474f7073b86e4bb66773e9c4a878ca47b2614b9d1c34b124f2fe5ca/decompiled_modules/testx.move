module 0x36affe745474f7073b86e4bb66773e9c4a878ca47b2614b9d1c34b124f2fe5ca::testx {
    struct TESTX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111      ");
        let v1 = trim_right(b"https://ai-agent.sgp1.cdn.digitaloceanspaces.com/images/d8356de4886498c960fb4ebcf7efb703_1740061579897_92WpWzZw_400x400.jpg                                                                                                                                                                                                     ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TESTX>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TESTX   ")))), trim_right(b"TEST_MAINNET                    "), trim_right(b"This token is for testing DaoX Mainnet (APE FOR MOON)                                                                                                                                                                                                                                                                           "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTX>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTX>>(v4);
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

