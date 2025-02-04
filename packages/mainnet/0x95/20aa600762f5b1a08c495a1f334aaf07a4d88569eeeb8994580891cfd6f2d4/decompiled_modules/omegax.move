module 0x9520aa600762f5b1a08c495a1f334aaf07a4d88569eeeb8994580891cfd6f2d4::omegax {
    struct OMEGAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: OMEGAX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FTBq3w9gCv27E451DV6w8AbUjBQbyVxxj1ZaYEYepump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<OMEGAX>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"OmegaX      ")))), trim_right(b"OmegaX Health                   "), trim_right(b"The AI doctor that never sleeps. OmegaX is redefining healthcare with 24/7 personalized AI, real-time insights, and proactive health optimization: seamless, intelligent, and built for the future on Solana.                                                                                                                   "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMEGAX>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OMEGAX>>(v4);
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

