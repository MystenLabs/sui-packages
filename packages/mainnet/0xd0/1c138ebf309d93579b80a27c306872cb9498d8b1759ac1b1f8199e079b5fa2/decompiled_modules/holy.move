module 0xd01c138ebf309d93579b80a27c306872cb9498d8b1759ac1b1f8199e079b5fa2::holy {
    struct HOLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FPAxCdhDRZstChLseMyL45KQn8JappC2bLfHEaYM3G9e.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HOLY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HOLY        ")))), trim_right(b"HOLYGAINS                       "), trim_right(x"57656c636f6d6520746f20486f6c79204761696e732c2020200a0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020546869732061696e277420796f75722061766572616765206d656d6520636f696e2e200a202020202020202020202020202020202020202020202020202020202020202020202020202020204974277320626c6573736564206279207468652063727970746f20676f647320616e642068656176656e732e200a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020204a657375732077696c6c20646566696e6974656c792066696c6c20796f757220626167732e2e2e2e2e2020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOLY>>(v4);
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

