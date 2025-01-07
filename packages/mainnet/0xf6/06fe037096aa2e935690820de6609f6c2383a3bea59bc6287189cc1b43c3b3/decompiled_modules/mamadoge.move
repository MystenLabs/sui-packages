module 0xf606fe037096aa2e935690820de6609f6c2383a3bea59bc6287189cc1b43c3b3::mamadoge {
    struct MAMADOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAMADOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FKHV3p9yqpkrF1KVPkbsciFwmQhwkk3FWyLxUDZpQxuE.png?size=lg&key=b9c0c6                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MAMADOGE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MAMADOGE")))), trim_right(b"Mama Dept of Gov Efficiency     "), trim_right(b"MamaDOGE is here to steal your heart and rocket your portfolio! This Solana token brings together the cuteness of Mama Doge and Mama Elon all in one adorable, power-packed package. Imagine a world where the next generation of crypto leaders is cute, mischievous, and ready to take over the blockchain playground!        "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAMADOGE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAMADOGE>>(v4);
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

