module 0x46f877410e192b5f47627cc9b2ed14de0b47c4ca7d1f30371ab74065a779e52c::rizzmas {
    struct RIZZMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIZZMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"e5bcfab736502b15d8245a55f57be918fc1cc4a004fbec2bde971bba51ab6bee                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RIZZMAS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"rizzmas     ")))), trim_right(b"Rizzmasrunner                   "), trim_right(x"434f4d4d554e4954592052554c455320202472697a7a6d617372756e6e65720a0a312e204d616b65207468697320636f696e207472656e64206f6e2074696b20746f6b200a0a322e205477656574202472697a7a6d617372756e6e6572206f6e20747769747465722073686f7720796f757220626167200a0a332e205368696c6c20262052616964200a0a342e20576f7264206f66204d6f7574682073707265616420202472697a7a6d617372756e6e65720a0a352e20456e6a6f7920746869732072756e6e657220686170707920686f6c6964617973202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIZZMAS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIZZMAS>>(v4);
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

