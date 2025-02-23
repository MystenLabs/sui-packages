module 0xf0dfd3e787182cfeb8759f70e392ba2f6d8e630ee15481635e47581672fb3b2d::solcasino {
    struct SOLCASINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLCASINO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"ZisOAd-W_aPP2yn3                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SOLCASINO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SOLCASINO   ")))), trim_right(b"Solcasino.io                    "), trim_right(x"536f6c636173696e6f20697320746865206f6666696369616c20636f696e206f662074686520546f7020312063727970746f20636173696e6f206f6e20536f6c616e61206e6574776f726b2e2050617961626c65206469726563746c7920746f20796f7572205765623320536f6c616e612077616c6c6574732077697468206c69766520636173696e6f2c20736c6f74732c2073706f7274732e0d0a0d0a466173742c207365637572652c20616e64207472616e73706172656e742067616d696e6720657870657269656e63652077697468206120776964652072616e6765206f662067616d65732e20456e6a6f7920736c6f74732c207461626c652067616d65732c20616e6420706f6b6572206f6e2074686520536f6c616e61206e6574776f726b2e0d0a0d0a546f7020323020627579657273206f6e204d6f6f6e73686f"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLCASINO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOLCASINO>>(v4);
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

