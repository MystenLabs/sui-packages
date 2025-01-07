module 0x3d4c9f6d7eedd73e73f57eb152b6a5f8c145bdbb9f162de6310f6169c925a044::aegis {
    struct AEGIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AEGIS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/5HMW7nJtQ1TZSG1T9FMbEMc72dHCFMUYGsNGP1Bnpump.png?size=lg&key=9e33be                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<AEGIS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"AEGIS   ")))), trim_right(b"AI DOGE SUI                     "), trim_right(b"$AEGIS - THE FIRST DOG CREATED BY ARTIFICIAL INTELLIGENCE Meet Aegis, my Al dog! Aegis is a sleek, metallic canine with glowing blue eyes and a sophisticated, cybernetic design.                                                                                                                                               "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AEGIS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AEGIS>>(v4);
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

