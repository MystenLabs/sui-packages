module 0x1a47aa8051734772663864e440a89e39ac205ebf11c2bb9bfb239467e686c550::redguy {
    struct REDGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: REDGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"e72b314736b36f671f6cfef78585101893e3f7b9525f590662669a0982b8a274                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<REDGUY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"REDGUY      ")))), trim_right(b"Just A Red Guy                  "), trim_right(x"5265644775792069732061204368726973746d6173206d656d65206c6567656e640a77686f7320616c6c2061626f7574206b656570696e6720697420636f7a7920616e640a63617265667265652e20486520646f65736e74207374726573732061626f7574207468650a686f6c696461792072757368206a75737420736970732068697320636f636f612c206368696c6c730a62792074686520747265652c20616e64206c6574732074686520676f6f642076696265730a726f6c6c2e204869732077686f6c6520766962653f204c6f776b657920666573746976650a63616c6d2c2063617375616c2c20616e6420616c7761797320696e2074686520686f6c696461790a7370697269742e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REDGUY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REDGUY>>(v4);
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

