module 0xc872a36440c7b6dc571e1eede45dfa0d2839ab290c2bf9024caf251afa0cb195::fair {
    struct FAIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAIR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"182a58d7a5c9450e0062ab01f7ba8ab8dda7a5c9127c7e62ec73f24ef5ef0e65                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FAIR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FAIR        ")))), trim_right(b"Fair Coin                       "), trim_right(x"416c6c2064657620666565732077696c6c20626520646973747269627574656420657175616c6c7920746f2074686f73652077686f20686f6c64204661697220436f696e20666f72206d6f7265207468616e203120686f75722e0a546865206c6f6e676572207468657920686f6c642c20746865206772656174657220746865697220726577617264732e0a417320746865206d61726b6574206361702067726f77732c2074686520746f74616c20646973747269627574696f6e20746f20686f6c646572732077696c6c20696e6372656173652e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAIR>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAIR>>(v4);
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

