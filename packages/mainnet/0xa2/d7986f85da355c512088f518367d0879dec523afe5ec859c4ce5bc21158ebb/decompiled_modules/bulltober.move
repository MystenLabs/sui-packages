module 0xa2d7986f85da355c512088f518367d0879dec523afe5ec859c4ce5bc21158ebb::bulltober {
    struct BULLTOBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLTOBER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"da8132ff7e35b53e5c96c3c942af6a2c1a3f5afbddbe141b6c84f88fdf3a1501                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BULLTOBER>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BULLTOBER   ")))), trim_right(b"The month the market wakes up   "), trim_right(b"Bulltober is the month the market wakes up. The bears retreat, the bulls rise from the shadows, and the stampede begins. Fueled by degen energy and Halloween madness, Bulltober marks the return of degen season on Solana.                                                                                                    "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLTOBER>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLTOBER>>(v4);
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

