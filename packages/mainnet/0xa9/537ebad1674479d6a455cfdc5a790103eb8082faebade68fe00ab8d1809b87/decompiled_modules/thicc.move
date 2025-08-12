module 0xa9537ebad1674479d6a455cfdc5a790103eb8082faebade68fe00ab8d1809b87::thicc {
    struct THICC has drop {
        dummy_field: bool,
    }

    fun init(arg0: THICC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/86y3kqM4Je3VEUs5sGvZhwCGXB5tn9UxWQ4He1JbkMLS.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<THICC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"THICC       ")))), trim_right(b"BigTiddyGothGF                  "), trim_right(b"Hello, yes, I'm a sad and lonely teenager who would like to order 5 big tiddie goth girls please, extra hair dye, extra eye liner, and extra THICC, hold the edge. I'd prefer a light spread of tender affection with 2 flops of Led Zeppelin fan T-shirts, 3 slit wrists, lightly scraped as so to not damage their arms, 2 pur"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THICC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THICC>>(v4);
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

