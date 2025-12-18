module 0x4454c3922600249c7226df366c24a47bd2a55d07f9f2c016e1271d6ae4ede47e::newyear {
    struct NEWYEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEWYEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"fa8b367c4b559f6ccf18125cc256c1fe3138939bd57dd484da79ae6895826372                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NEWYEAR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NEWYEAR     ")))), trim_right(b"New Year Cult                   "), trim_right(b"New Year Cult started as a random late-night sketch that somehow exploded into a full-blown chaos squad. Five unhinged weirdos in party hats, throwing hand signs, jumping around, and acting like every hour is five minutes before midnight.                                                                                  "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEWYEAR>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEWYEAR>>(v4);
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

