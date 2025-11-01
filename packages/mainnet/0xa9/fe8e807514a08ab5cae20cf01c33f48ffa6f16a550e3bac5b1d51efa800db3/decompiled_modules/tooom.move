module 0xa9fe8e807514a08ab5cae20cf01c33f48ffa6f16a550e3bac5b1d51efa800db3::tooom {
    struct TOOOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"594d542a1c7294831d5879af3e108b101f3abf3e50ca5e75a1d6ee1082d3a755                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TOOOM>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Tooom       ")))), trim_right(b"There's only one of me          "), trim_right(b"Tooom was born from a burst of energy deep inside the Echo Grid, a mysterious digital-physical realm where thought becomes matter. Unlike others of his kindwho appear as reflections or copies within the gridTooom was the only one who solidified completely. Thats why he always says: There's only one of me.....          "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOOOM>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOOOM>>(v4);
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

