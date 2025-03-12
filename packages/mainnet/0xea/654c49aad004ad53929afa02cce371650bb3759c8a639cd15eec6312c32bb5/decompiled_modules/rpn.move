module 0xea654c49aad004ad53929afa02cce371650bb3759c8a639cd15eec6312c32bb5::rpn {
    struct RPN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RPN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"u4s5QvXg-IhYCyc5                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RPN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RPN         ")))), trim_right(b"Red Panda Nation                "), trim_right(b"Allow me 2 reintroduce myself: I'm RPN token on SOL, the newest member of the meme coin petting zoo. Wanna see red pandas while getting rich? Join the nation!                                                                                                                                                                  "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RPN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RPN>>(v4);
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

