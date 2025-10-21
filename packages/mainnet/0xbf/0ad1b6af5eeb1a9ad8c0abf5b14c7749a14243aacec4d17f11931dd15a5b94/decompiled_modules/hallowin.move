module 0xbf0ad1b6af5eeb1a9ad8c0abf5b14c7749a14243aacec4d17f11931dd15a5b94::hallowin {
    struct HALLOWIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HALLOWIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"ccff95a76e196a8558ebe0b6ecedf79d5260ceaf77380b0c122df56726f81337                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HALLOWIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HALLOWIN    ")))), trim_right(b"Halloween PVE play              "), trim_right(b"Finally the PvE play is here! We all will win in Hallowin                                                                                                                                                                                                                                                                       "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HALLOWIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HALLOWIN>>(v4);
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

