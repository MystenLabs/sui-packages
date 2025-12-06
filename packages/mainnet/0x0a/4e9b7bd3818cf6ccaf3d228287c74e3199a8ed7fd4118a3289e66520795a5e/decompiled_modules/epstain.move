module 0xa4e9b7bd3818cf6ccaf3d228287c74e3199a8ed7fd4118a3289e66520795a5e::epstain {
    struct EPSTAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EPSTAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"3ae601ab23e0d81a9e7565dec55dae8083dcec5cb4a23bfde1c1add0e04314d8                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<EPSTAIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"EPSTAIN     ")))), trim_right(b"Jeffrey Epstain                 "), trim_right(b"Elon Musk is committed to reveal the truth about Jeffrey Epstein mystery.  The pandora box to be opened.  Countdown begins now, with every tweet from Elon.   Truth will come out!                                                                                                                                              "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EPSTAIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EPSTAIN>>(v4);
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

