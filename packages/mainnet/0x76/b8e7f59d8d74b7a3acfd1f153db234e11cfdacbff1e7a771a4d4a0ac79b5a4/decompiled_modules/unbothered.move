module 0x76b8e7f59d8d74b7a3acfd1f153db234e11cfdacbff1e7a771a4d4a0ac79b5a4::unbothered {
    struct UNBOTHERED has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNBOTHERED, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2foEbauo7SQFjCxiEnLd11AoS3aoc9vXWTY7jGNMpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<UNBOTHERED>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"unbothered  ")))), trim_right(b"In My Lane. Focused. Flourishing"), trim_right(b"Unbothered. Moisturized. Happy. In My Lane. Focused. Flourishing.                                                                                                                                                                                                                                                               "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNBOTHERED>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNBOTHERED>>(v4);
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

