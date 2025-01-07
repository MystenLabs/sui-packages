module 0xddf8f2384216ceffab475d29676f55f6a873030ac90d6ef6187ad1db608993d4::chikn {
    struct CHIKN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHIKN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CHIKN>>(0x2::coin::mint<CHIKN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CHIKN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DhP6kdeJ83aBrasFRuKgBChBWxgSBQGxNgDjN18Epump.png?size=lg&key=650d31                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CHIKN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CHIKN   ")))), trim_right(b"Chikn.nuggit                    "), trim_right(b"Chikn Nuggit (CHIKN) is the official token celebrating the wildly popular animated web series by Kyra Kupetsky, loved by millions across TikTok, X, Instagram, and YouTube.                                                                                                                                                     "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHIKN>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHIKN>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<CHIKN>>(0x2::coin::mint<CHIKN>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

