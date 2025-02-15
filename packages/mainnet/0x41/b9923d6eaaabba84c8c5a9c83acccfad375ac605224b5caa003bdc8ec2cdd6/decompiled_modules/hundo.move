module 0x41b9923d6eaaabba84c8c5a9c83acccfad375ac605224b5caa003bdc8ec2cdd6::hundo {
    struct HUNDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUNDO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"GS-11FAiRHvwNNIC                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HUNDO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HUNDO       ")))), trim_right(b"Invest $HUNDO dollars           "), trim_right(b"Invest $HUNDO dollars DEV holds $100 dollars  Fair Community Token Launch   work for your bags you are the dev people Im going to leave marketing wallet below CejDkpvMToinRWgbQfgJWHih6c8gPAAJpYcmEW4pev1T                                                                                                                     "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUNDO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUNDO>>(v4);
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

