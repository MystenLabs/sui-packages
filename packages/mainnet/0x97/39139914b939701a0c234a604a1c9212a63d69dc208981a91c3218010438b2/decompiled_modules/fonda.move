module 0x9739139914b939701a0c234a604a1c9212a63d69dc208981a91c3218010438b2::fonda {
    struct FONDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FONDA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/A3GCAAwFxAUgx97j9uw8Vkf8MaFqUut2tsyAXq9Cpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FONDA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FOND        ")))), trim_right(b" Fondue Coin                    "), trim_right(x"466f6e64756520436f696e202024464f4e440a426f726e20696e2074686520537769737320416c707320204275696c74206f6e20536f6c616e612e0a4d6f7265207468616e2061206d656d65202069747320612063756c747572616c20746f6b656e20776865726520666c61766f72206d6565747320666f6375732e0a412063616c6d2c206465666c6174696f6e617279206d656c7420706f7765726564206279206d757369632c2067616d696e672026207265616c20636f6d6d756e6974792e0a0a205765656b6c79206275726e732072656475636520746f74616c20737570706c792066756c6c79207472616e73706172656e74206f6e20636861696e2e0a2050726f746563746564206279207468652042656c6c20466f7263653a2057696c68656c6d2c2042656c6c6120262057616c7465722e0a20526f61646d6170"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FONDA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FONDA>>(v4);
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

