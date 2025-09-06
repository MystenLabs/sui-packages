module 0x4cdd374e650ebb51986f8ed86b9cd16bf78e43ce21f99b5dddd6e686d784cc73::xvm {
    struct XVM has drop {
        dummy_field: bool,
    }

    fun init(arg0: XVM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"5e92f618fc8e79dd27f5c8ebfa47761c667a6c6b28c01906b031c1c0ed7a6a80                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<XVM>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"XVM         ")))), trim_right(b"Volt                            "), trim_right(b"Supercharging the next generation of RWA on XRP.                                                                                                                                                                                                                                                                                "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XVM>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XVM>>(v4);
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

