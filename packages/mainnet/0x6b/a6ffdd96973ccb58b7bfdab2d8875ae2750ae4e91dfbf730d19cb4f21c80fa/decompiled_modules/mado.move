module 0x6ba6ffdd96973ccb58b7bfdab2d8875ae2750ae4e91dfbf730d19cb4f21c80fa::mado {
    struct MADO has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MADO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MADO>>(0x2::coin::mint<MADO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MADO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/bsc/0x77ed4e6d616bcd773328d61cf2690225e4cca238.png?size=lg&key=8b8e9f                                                                                                                                                                                                                 ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MADO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MADO    ")))), trim_right(b"Mars Doge                       "), trim_right(b"Mars Doge honors Elon Musk, pioneer of Martian civilization, symbolizing humanity's dream of interstellar travel. As spaceships ascend, humanity gains infinite possibilities, with Mars as the first destination                                                                                                               "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MADO>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MADO>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<MADO>>(0x2::coin::mint<MADO>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

