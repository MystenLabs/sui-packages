module 0x874b05ed013f7cc37a9911f6af24aa51ebdab06424981963d76578c359493a1b::ran {
    struct RAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"11111111    ");
        let v1 = trim_right(b"https://pbs.twimg.com/profile_images/1792571582902095872/1h0Tm7RU_400x400.jpg                                                                                                                                                                                                                                                   ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RAN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RAN     ")))), trim_right(b"FERR                            "), trim_right(b"Token creator token.dj sfjfiosd p                                                                                                                                                                                                                                                                                               "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAN>>(v4);
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

