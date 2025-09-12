module 0x607a5e933c6b26809190441c423bc9460583b0bc409e54ddcc4f6725429dca0b::blackflag {
    struct BLACKFLAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACKFLAG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"63c140254aa2b1d41e4a9735bb24c1d656d05fd1d9b5999fc8ed13f119f119cd                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BLACKFLAG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"blackflag   ")))), trim_right(b"black flag                      "), trim_right(b"The black flag first entered the American imagination through artist Jasper Johns in the 1950s, who stripped away its colors to challenge viewers with stark ambiguity  patriotism, protest, or both. Decades later, it has been reclaimed by a new generation as a banner of defiance. Shared on streets and across social plat"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACKFLAG>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLACKFLAG>>(v4);
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

