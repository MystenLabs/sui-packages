module 0x16b68d3397dbb8dabaceb2e5ea5e8a7486079a09b783f16d616b473377b24d89::mdgscr {
    struct MDGSCR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDGSCR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Hy3Nu2AezhsGhDjqum5WXR9tohSdeD9H2D5z1ChoqiQJ.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MDGSCR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MDGSCR      ")))), trim_right(b"Visit MDGSCR                    "), trim_right(b"Discover Madagascar with Visit MDGSCR ! Our unique tourist token promotes the beauty, history, and culture of our island nation . Join us to unite explorers and welcome tourists to the heart of Madagascars wonders Invest in adventure, invest in MDGSCR! Invest in our and your prosperity                                  "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDGSCR>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MDGSCR>>(v4);
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

