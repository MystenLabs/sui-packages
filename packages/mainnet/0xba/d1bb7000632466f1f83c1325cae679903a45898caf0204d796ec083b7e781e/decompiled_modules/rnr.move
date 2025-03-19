module 0xbad1bb7000632466f1f83c1325cae679903a45898caf0204d796ec083b7e781e::rnr {
    struct RNR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RNR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/u2gm1bUHQe6MwkDyb31UFSLmNBGKcQ7mrkarodFpump.png?claimId=CR1IgVfA9d5q5NJP                                                                                                                                                                                                       ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RNR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RNR         ")))), trim_right(b"Rich Nigga Rooster              "), trim_right(b"GOATED PREMIUM ROOSTER  BUSSIN'  STRAIGHT FLEXIN'  STACKIN' BANDS  NO SLEEP TILL THE BANK BREAK  POPPIN' BOTTLES IN THE CLUB                                                                                                                                                                                                    "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RNR>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RNR>>(v4);
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

